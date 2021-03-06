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
#' @inheritParams effsize_repeated
#' @param paired Indicator, if repeated measures should be used.
#'
#' @return A tibble
compute_hedges_g <- function(data, id = NULL, grouping_factor, variable, paired = FALSE, detailed = FALSE) {

    effectsizes <- NULL

  # possible pairwise comparisons und used (!) levels
  comparisons <- data %>%
    droplevels() %>%
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
          id = {{ id }},
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
#' @inheritParams effsize_repeated
#' @param paired Indicator, if repeated measures effect sizes should be used.
#'   Default is \code{FALSE}.
#'
#' @return A tibble
#' @export
#'
#' @examples
#' hedges_g(data = phantasialand, grouping_factor = backpack, variable = joy)
hedges_g <- function(data, id = NULL, grouping_factor, variable, paired = FALSE, detailed = FALSE) {
  if (!is.factor(pull({{ data }}, {{ grouping_factor }}))) {
    stop("The grouping variable must be a factor.")
  }

  if (!is.numeric(pull({{ data }}, {{ variable }}))) {
    stop("The dependent variable must be numeric.")
  }

  if (paired & missing(id)) {
    stop("For repeated measures effect sizes, a subject identifier must be supplied as id.")
  }


  if (is_grouped_df({{ data }})) {
    data %>%
      group_modify(~ compute_hedges_g(
        data = .,
        id = {{ id }},
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
      id = {{ id }},
      grouping_factor = {{ grouping_factor }},
      variable = {{ variable }},
      paired = paired,
      detailed = detailed
    )
  }
}
