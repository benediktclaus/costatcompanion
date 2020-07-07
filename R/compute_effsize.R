#' Compute Pairwise Effect Sizes
#'
#' This function computes pairwise independent effect sizes (Hedges' \eqn{g} and
#' \eqn{g*}) for a continous variable based on a grouping variable.
#'
#' @importFrom rstatix get_comparisons
#' @importFrom magrittr `%>%`
#' @importFrom purrr map
#' @importFrom tibble as_tibble_col
#' @importFrom tidyr unnest
#'
#' @inheritParams get_effsize
#'
#' @return A tibble
#' @export
compute_effsize <- function(data, grouping_factor, variable, paired = FALSE, participant_id, detailed = FALSE) {
  effectsizes <- NULL
  # possible pairwise comparisons
  comparisons <- data %>%
    get_comparisons({{ grouping_factor }})

  # compute effect sizes for each comparison
  comparisons %>%
    map(~ get_effsize(data = {{ data }}, grouping_factor = {{ grouping_factor }}, grouping_levels = ., variable = {{ variable }}, detailed = detailed)) %>%
    as_tibble_col(column_name = "effectsizes") %>%
    unnest(effectsizes)
}
