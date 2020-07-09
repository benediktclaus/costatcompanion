#' Compute Effect Sizes for Independent Measures
#'
#' Compute Hedges' g and g* for indenpendent groups.
#'
#' @importFrom magrittr `%>%`
#' @importFrom dplyr filter group_by
#' @importFrom rstatix get_summary_stats
#' @importFrom purrr pluck
#' @importFrom tibble tibble
#'
#' @param data Data frame containing the data
#' @param grouping_factor Factor, used for the comparisons between groups
#' @param grouping_levels Concatenated string, the levels of the grouping factor
#'   that should be compared
#' @param variable Numeric, the dependent variable
#' @param detailed Indicator, if detailed information (such as means, standard
#'   deviations, etc.) should be returned. Default ist \code{FALSE}
#'
#' @return A tibble
effsize_independent <- function(data, grouping_factor, grouping_levels, variable, detailed = FALSE) {
  # get descriptives
  descriptives <- data %>%
    filter({{ grouping_factor }} %in% {{ grouping_levels }}) %>%
    group_by({{ grouping_factor }}) %>%
    get_summary_stats({{ variable }}, type = "mean_sd")

  # extract descriptives
  level_1 <- pluck(descriptives, 1, 1)
  level_2 <- pluck(descriptives, 1, 2)
  mean_1 <- pluck(descriptives, "mean", 1)
  mean_2 <- pluck(descriptives, "mean", 2)
  sd_1 <- pluck(descriptives, "sd", 1)
  sd_2 <- pluck(descriptives, "sd", 2)
  n_1 <- pluck(descriptives, "n", 1)
  n_2 <- pluck(descriptives, "n", 2)

  # compute components
  mean_diff <- mean_2 - mean_1
  s_pooled <- sqrt((sd_1^2 + sd_2^2) / 2)
  s_corrected <- sqrt(((n_1 - 1) * sd_1^2 + (n_2 - 1) * sd_2^2) / (n_1 + n_2 - 2))
  alpha <- n_1 + n_2 - 2
  j <- 1 - (3 / ((4 * alpha) - 1))

  # compute effect sizes
  cohens_d <- mean_diff / s_pooled
  hedges_g <- mean_diff / s_corrected
  g_star <- j * hedges_g

  # compute variances
  var_g <- ((n_1 + n_2) / (n_1 * n_2)) + (hedges_g^2 / (2 * (n_1 + n_2)))
  se_g <- sqrt(var_g)
  var_g_star <- j^2 * var_g
  se_g_star <- sqrt(var_g_star)

  # conversion to r
  a <- (n_1 + n_2)^2 / (n_1 * n_2)
  r <- g_star / sqrt(g_star^2 + a)

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
      "mean_diff" = mean_diff,
      "s_pooled" = s_pooled,
      "s_corrected" = s_corrected,
      "cohens_d" = cohens_d,
      "hedges_g" = hedges_g,
      "g_star" = g_star,
      "lower" = g_star - (1.9599 * var_g_star),
      "upper" = g_star + (1.9599 * var_g_star),
      "r" = r
    )
  } else {
    tibble(
      "group_1" = level_1,
      "group_2" = level_2,
      "n_1" = n_1,
      "n_2" = n_2,
      "hedges_g" = hedges_g,
      "g_star" = g_star,
      "lower" = g_star - (1.9599 * var_g_star),
      "upper" = g_star + (1.9599 * var_g_star),
      "r" = r
    )
  }
}


#' Compute Effect Sizes for Repeated Measures
#'
#' @importFrom magrittr `%>%`
#' @importFrom dplyr filter group_by
#' @importFrom rstatix get_summary_stats cor_test
#' @importFrom purrr pluck
#' @importFrom tibble tibble
#' @importFrom tidyr pivot_wider
#' @importFrom stats na.omit
#'
#' @inheritParams effsize_independent
#'
#' @return A tibble
effsize_repeated <- function(data, grouping_factor, grouping_levels, variable, detailed = FALSE) {

  # create complete paired data (without missings)
  paired_df <- data %>%
    filter({{ grouping_factor }} %in% {{ grouping_levels }}) %>%
    pivot_wider(
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
  j <- 1 - (3 / (4 * (n - 1) - 1))

  # compute effect sizes
  hedges_g <- mean_diff / s_within
  g_star <- j * hedges_g

  # compute variances
  var_g <- ((1 / n) + (hedges_g^2 / (2 * n))) * 2 * (1 - correlation)
  se_g <- sqrt(var_g)
  var_g_star <- j^2 * var_g
  se_g_star <- sqrt(var_g_star)

  # conversion to r
  r <- g_star / sqrt(g_star^2 + 4)

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
      "mean_diff" = mean_diff,
      "s_within" = s_within,
      "correlation" = correlation,
      "hedges_g" = hedges_g,
      "g_star" = g_star,
      "lower" = g_star - (1.95996 * var_g_star),
      "upper" = g_star + (1.95996 * var_g_star),
      "r" = r
    )
  } else {
    tibble(
      "group_1" = level_1,
      "group_2" = level_2,
      "n_pairs" = n,
      "hedges_g" = hedges_g,
      "g_star" = g_star,
      "lower" = g_star - (1.95996 * var_g_star),
      "upper" = g_star + (1.95996 * var_g_star),
      "r" = r
    )
  }
}
