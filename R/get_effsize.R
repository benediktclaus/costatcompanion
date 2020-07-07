#' Compute Effect Sizes
#'
#' This function computes effect sizes for continuous variables based on
#' grouping variables.
#'
#' @importFrom magrittr `%>%`
#' @importFrom rstatix get_summary_stats cor_test
#' @importFrom purrr pluck
#' @importFrom tibble tibble
#' @importFrom dplyr filter group_by pull
#' @importFrom tidyr pivot_wider
#' @importFrom stats na.omit
#'
#' @param data Data frame
#' @param grouping_factor Factor, a variable used to group upon
#' @param grouping_levels Strings, two concatenated strings to use as factor
#'   levels for comparison
#' @param variable Numeric, a dependent variable
#' @param paired Indicator, if \code{TRUE}, repeated measures effect sizes will
#'   be calculated
#' @param participant_id A column in the data frame containing a participant
#'   identifier. This is needed only for repeated measures effect sizes
#' @param detailed Indicator, if \code{FALSE} (default) detailed statistics will
#'   be omitted
#'
#' @return A tibble
get_effsize <- function(data, grouping_factor, grouping_levels, variable, paired = FALSE, participant_id, detailed = FALSE) {
  # check data types
  if (!is.numeric(pull({{ data }}, {{ variable }}))) {
    stop("The dependent variable needs to be numeric.")
  }
  if (!is.factor(pull({{ data }}, {{ grouping_factor }}))) {
    stop("The grouping variable needs to be a factor.")
  }

  if (!paired) {
    # get grouping levels
    level_1 <- pluck({{ grouping_levels }}, 1)
    level_2 <- pluck({{ grouping_levels }}, 2)

    # get descriptives
    descriptives_1 <- data %>%
      filter({{ grouping_factor }} == {{ level_1 }}) %>%
      get_summary_stats({{ variable }}, type = "mean_sd")

    descriptives_2 <- data %>%
      filter({{ grouping_factor }} == {{ level_2 }}) %>%
      get_summary_stats({{ variable }}, type = "mean_sd")

    # extract descriptives
    mean_1 <- pluck(descriptives_1, "mean")
    mean_2 <- pluck(descriptives_2, "mean")
    sd_1 <- pluck(descriptives_1, "sd")
    sd_2 <- pluck(descriptives_2, "sd")
    n_1 <- pluck(descriptives_1, "n")
    n_2 <- pluck(descriptives_2, "n")

    # compute components
    mean_diff <- mean_2 - mean_1
    s_pooled <- sqrt((sd_1^2 + sd_2^2) / 2)
    s_corrected <- sqrt(((n_1 - 1) * sd_1^2 + (n_2 - 1) * sd_2^2) / (n_1 + n_2 - 2))
    alpha <- n_1 + n_2 - 2
    j <- gamma(alpha / 2) / (sqrt(alpha / 2) * gamma((alpha - 1) / 2))

    # compute effect sizes
    cohens_d <- mean_diff / s_pooled
    hedges_g <- mean_diff / s_corrected
    g_star <- j * hedges_g

    # compute variances
    var_g <- ((n_1 + n_2) / (n_1 * n_2)) + (hedges_g^2 / (2 * (n_1 + n_2)))
    se_g <- sqrt(var_g)
    var_g_star <- j^2 * var_g
    se_g_star <- sqrt(var_g_star)

    # output
    if (detailed) {
      tibble(
        "group_1" = level_1,
        "group_2" = level_2,
        "mean_1" = mean_1,
        "mean_2" = mean_2,
        "sd_1" = sd_1,
        "sd_2" = sd_2,
        "n_1" = n_1,
        "n_2" = n_2,
        "cohens_d" = cohens_d,
        "hedges_g" = hedges_g,
        "g_star" = g_star,
        "lower" = g_star - (1.959964 * var_g_star),
        "upper" = g_star + (1.959964 * var_g_star),
        "var_g_star" = var_g_star
      )
    } else {
      tibble(
        "group_1" = level_1,
        "group_2" = level_2,
        "n_1" = n_1,
        "n_2" = n_2,
        "hedges_g" = hedges_g,
        "g_star" = g_star,
        "lower" = g_star - (1.959964 * var_g_star),
        "upper" = g_star + (1.959964 * var_g_star)
      )
    }
  } else {
    if (missing(participant_id)) {
      stop("For repeated measures effect sizes, a participant ID is nedded.")
    }

    # create complete paired data (without missings)
    paired_df <- data %>%
      filter({{ grouping_factor }} %in% {{ grouping_levels }}) %>%
      pivot_wider(
        id_cols = {{ participant_id }},
        names_from = {{ grouping_factor }},
        values_from = {{ variable }}
      ) %>%
      na.omit()

    # get descriptives
    descriptives_paired <- paired_df %>%
      get_summary_stats(type = "mean_sd")

    # extract descriptives
    level_1 <- pluck(descriptives_paired, "variable", 1)
    level_2 <- pluck(descriptives_paired, "variable", 2)
    mean_1 <- pluck(descriptives_paired, "mean", 1)
    mean_2 <- pluck(descriptives_paired, "mean", 2)
    sd_1 <- pluck(descriptives_paired, "sd", 1)
    sd_2 <- pluck(descriptives_paired, "sd", 2)
    n <- pluck(descriptives_paired, "n", 1)

    # correlation
    correlation <- paired_df %>%
      cor_test(vars = {{ level_1 }}, vars2 = {{ level_2 }}) %>%
      pluck("cor") %>%
      abs()

    # compute components
    mean_diff <- mean_2 - mean_1
    s_diff <- sqrt((sd_1^2 + sd_2^2) - (2 * correlation * sd_1 * sd_2))
    s_within <- s_diff / (sqrt(2 * (1 - correlation)))
    j <- 1 - (3 / (4 * (n -1) - 1))

    # compute effect sizes
    hedges_g <- mean_diff / s_within
    g_star <- j * hedges_g

    # compute variances
    var_g <- ((1 / n) + (hedges_g^2 / (2 * n))) * 2 * (1 - correlation)
    se_g <- sqrt(var_g)
    var_g_star <- j^2 * var_g
    se_g_star <- sqrt(var_g_star)

    # output
    if (detailed) {
      tibble(
        "group_1" = level_1,
        "group_2" = level_2,
        "mean_1" = mean_1,
        "mean_2" = mean_2,
        "sd_1" = sd_1,
        "sd_2" = sd_2,
        "n_pairs" = n,
        "correlation" = correlation,
        "hedges_g" = hedges_g,
        "g_star" = g_star,
        "lower" = g_star - (1.959964 * var_g_star),
        "upper" = g_star + (1.959964 * var_g_star)
      )
    } else {
      tibble(
        "group_1" = level_1,
        "group_2" = level_2,
        "n_pairs" = n,
        "hedges_g" = hedges_g,
        "g_star" = g_star,
        "lower" = g_star - (1.959964 * var_g_star),
        "upper" = g_star + (1.959964 * var_g_star)
      )
    }
  }
}
