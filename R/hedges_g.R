#' Combine Effect Sizes in Single Function
#'
#' This function computes pairwise independent effect sizes (Hedges' \eqn{g} and
#' \eqn{g*}) for a continuous variable based on a grouping variable.
#'
#' @importFrom magrittr `%>%`
#' @importFrom dplyr pull
#' @importFrom rstatix get_comparisons
#' @importFrom purrr map
#' @importFrom tibble as_tibble_col
#' @importFrom tidyr unnest
#'
#' @inheritParams effsize_independent
#' @param paired Indicator, if repeated measures should be used.
#'
#' @return A tibble
compute_hedges_g <- function(data, grouping_factor, variable, paired = FALSE, detailed = FALSE) {

    effectsizes <- NULL
  # possible pairwise comparisons
  comparisons <- data %>%
    get_comparisons({{ grouping_factor }})

  if (!paired) {
    comparisons %>%
      map(
        ~ effsize_independent(
          data = {{ data }},
          grouping_factor = {{ grouping_factor }},
          grouping_levels = .,
          variable = {{ variable }},
          detailed = detailed
        )
      ) %>%
      as_tibble_col(column_name = "effectsizes") %>%
      unnest(effectsizes)
  } else {
    comparisons %>%
      map(
        ~ effsize_repeated(
          data = {{ data }},
          grouping_factor = {{ grouping_factor }},
          grouping_levels = .,
          variable = {{ variable }},
          detailed = detailed
        )
      ) %>%
      as_tibble_col(column_name = "effectsizes") %>%
      unnest(effectsizes)
  }
}


#' Compute Effect Sizes for Pairwise Comparisons
#'
#' This function computes pairwise independent effect sizes (Hedges' \eqn{g} and
#' \eqn{g*}) for a continuous variable based on a grouping variable.
#'
#' @importFrom dplyr is_grouped_df group_modify ungroup
#'
#' @inheritParams effsize_independent
#' @param paired Indicator, if repeated measures effect sizes should be used.
#'
#' @return A tibble
#' @export
hedges_g <- function(data, grouping_factor, variable, paired = FALSE, detailed = FALSE) {
  if (!is.factor(pull({{ data }}, {{ grouping_factor }}))) {
    stop("The grouping variable must be a factor.")
  }

  if (!is.numeric(pull({{ data }}, {{ variable }}))) {
    stop("The dependent variable must be numeric.")
  }


  if (is_grouped_df({{ data }})) {
    data %>%
      group_modify(~ compute_hedges_g(
        data = .,
        grouping_factor = {{grouping_factor}},
        variable = {{ variable }},
        paired = paired,
        detailed = detailed
      )
      ) %>%
      ungroup()
  } else {
    compute_hedges_g(
      data = {{ data }},
      grouping_factor = {{ grouping_factor }},
      variable = {{ variable }},
      paired = paired,
      detailed = detailed
    )
  }
}
