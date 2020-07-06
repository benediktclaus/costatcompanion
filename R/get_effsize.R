#' Compute Effect Sizes
#'
#' This function computes effect sizes for continuous variables based on
#' grouping variables.
#'
#' @importFrom magrittr `%>%`
#' @importFrom rstatix get_summary_stats
#' @importFrom purrr pluck
#' @importFrom tibble tibble
#' @importFrom dplyr filter group_by pull
#'
#' @param data Data frame
#' @param grouping_factor Factor, a variable used to group upon
#' @param grouping_levels Strings, two concatenated strings to use as factor
#'   levels for comparison
#' @param variable Numeric, a dependent variable
#' @param detailed Indicator, if \code{FALSE} (default) detailed statistics
#'   will be omitted
#'
#' @return A tibble
#'
get_effsize <- function(data, grouping_factor, grouping_levels, variable, detailed = FALSE) {
  # check data types
  if (!is.numeric(pull({{ data }}, {{ variable }}))) {
    stop("The dependent variable needs to be numeric.")
  }
  if (!is.factor(pull({{ data }}, {{ grouping_factor }}))) {
    stop("The grouping variable needs to be a factor.")
  }

  # get descriptives
  descriptives <- data %>%
    filter({{ grouping_factor }} %in% {{ grouping_levels }}) %>%
    group_by({{ grouping_factor }}) %>%
    get_summary_stats({{ variable }}, type = "mean_sd")

  # extract descriptives
  group_1 <- pluck(descriptives, 1, 1)
  group_2 <- pluck(descriptives, 1, 2)
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
      "group_1" = group_1,
      "group_2" = group_2,
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
      "group_1" = group_1,
      "group_2" = group_2,
      "n_1" = n_1,
      "n_2" = n_2,
      "hedges_g" = hedges_g,
      "g_star" = g_star,
      "lower" = g_star - (1.959964 * var_g_star),
      "upper" = g_star + (1.959964 * var_g_star)
    )
  }
}
