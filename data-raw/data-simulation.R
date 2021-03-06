# Pakete ------------------------------------------------------------------
library(tidyverse)


# Regression --------------------------------------------------------------
# Korrelation
set.seed(20200609)
water_park <- MASS::mvrnorm(100, mu = c(0,0,0,0), Sigma = matrix(c(1, 0.86, 0.79, 0.75, 0.86, 1, 0.95, 0.80, 0.79, 0.95, 1, 0.70, 0.75, 0.80, 0.70, 1), ncol = 4), empirical = TRUE) %>%
  as_tibble(.name_repair = "unique") %>%
  rename(temperature = "...1", swimmers = "...2", sales = "...3", beatings = "...4") %>%
  mutate(temperature = round(temperature * 6 + 25, 1),
         swimmers = round(swimmers * 30 + 100),
         sales = round(sales * 500 + 1500),
         beatings = round(beatings * 2 + 5)) %>%
  rownames_to_column(var = "day_id")

use_data(water_park, overwrite = TRUE)

# Repeated Measures Correlation
compute_rmcorr_data <- function(n = 5, mean_x = 0, mean_y = 0, correlation = -0.80, speed_scaling = 1) {
  MASS::mvrnorm(
    n = n,
    mu = c(mean_x, mean_y),
    Sigma = matrix(
      c(1, correlation, correlation, 1),
      nrow = 2,
      dimnames = list(c("speed", "accuracy"))
    ),
    empirical = TRUE
  ) %>%
    as_tibble() %>%
    mutate(speed = speed * speed_scaling)
}

set.seed(20200624)
typing <- tibble(
  x = runif(100, 5, 110),
  y_fitted = x * 0.8 + 10,
  errors = rnorm(100, sd = 5),
  y = pmin(y_fitted + errors, 100)
) %>%
  select(x, y) %>%
  filter(y > 25) %>%
  rownames_to_column(var = "id") %>%
  rowwise() %>%
  mutate(
    individual_data = list(compute_rmcorr_data(mean_x = x, mean_y = y, speed_scaling = 5))
  ) %>%
  unnest(individual_data) %>%
  mutate(
    accuracy = pmin(accuracy, 100),
    trial = rep(1:5, times = 87)
  ) %>%
  select(id, trial, speed, accuracy)

use_data(typing, overwrite = TRUE)


# t-Tests -----------------------------------------------------------------
# Einstichproben-t-Test
set.seed(20200422)
ravenclaw <- tibble("intelligence" = round(rnorm(48, 125, 15))) %>%
  rownames_to_column(var = "id")

use_data(ravenclaw, overwrite = TRUE)


# t-Test für unabhängige Stichproben
set.seed(20200422)
chivalry <- tibble(
  house = as_factor(c("Gryffindor", "Slytherin")),
  chivalry = list(round(rnorm(n = 42, mean = 95, sd = 8)), round(rnorm(n = 38, mean = 45, sd = 9)))
) %>%
  unnest(chivalry) %>%
  rownames_to_column(var = "id")

use_data(chivalry, overwrite = TRUE)


# t-Test für verbundene Stichproben
set.seed(20200422)
patience <- tibble(
  measurement = as_factor(c("Begin", "End")),
  patience = list(round(rnorm(53, 44, 8)), round(rnorm(53, 46, 9)))
) %>%
  unnest(patience) %>%
  add_column(id = as.character(rep(1:53, 2)), .before = "measurement")

use_data(patience, overwrite = TRUE)


# ANOVAs ------------------------------------------------------------------
# Einfaktorielle ANOVA
set.seed(20200428)
phantasialand <- tibble(
  backpack = as_factor(c("None", "Light", "Heavy", "Handcart")),
  joy = list(round(rnorm(42, 9, 1.3)), round(rnorm(53, 7, 1.5)), round(rnorm(56, 6.5, 1.5)), round(rnorm(35, 3, 1.7)))
) %>%
  unnest(joy) %>%
  mutate(joy = pmin(joy, 10),
         joy = pmax(joy, 0)) %>%
  sample_n(size = nrow(.)) %>%
  rownames_to_column(var = "id")

use_data(phantasialand, overwrite = TRUE)

# Faktorielle ANOVA
set.seed(20200504)
ice_cream <- crossing(flavor = as_factor(c("Vanilla", "Chocolate", "Cookie", "Champagne")),
         sex = as_factor(c("Female", "Male"))) %>%
  add_column(yumminess = list(
    round(rnorm(36, 17, 2)),
    round(rnorm(38, 16, 2.1)),
    round(rnorm(41, 17.5, 1.9)),
    round(rnorm(40, 17.3, 1.7)),
    round(rnorm(45, 16, 2.3)),
    round(rnorm(35, 13, 2.4)),
    round(rnorm(40, 15.5, 2.2)),
    round(rnorm(20, 8, 2.4))
  )) %>%
  unnest(yumminess) %>%
  mutate(yumminess = pmin(yumminess, 20)) %>%
  sample_n(size = nrow(.)) %>%
  rownames_to_column(var = "id")

use_data(ice_cream, overwrite = TRUE)

# ANOVA mit Messwiederholungen
set.seed(20200518)
runners <- tibble(
  "bad" = rnorm(51, mean = 10, sd = 3),
  "neutral" = rnorm(51, mean = 16, sd = 3),
  "favorite" = rnorm(51, mean = 25, sd = 3)
) %>%
  rownames_to_column(var = "id") %>%
  pivot_longer(
    cols = -id,
    names_to = "music_type",
    values_to = "endurance",
    names_ptypes = list(music_type = factor())
  ) %>%
  mutate(endurance = round(endurance),
         endurance = pmax(endurance, 0),
         endurance = pmin(endurance, 30))

use_data(runners, overwrite = TRUE)

# Faktorielle ANOVA mit Messwiederholung
set.seed(20200528)
runners_motivation <- tibble(
  "bad_no" = rnorm(51, mean = 10, sd = 3),
  "neutral_no" = rnorm(51, mean = 11, sd = 3),
  "favorite_no" = rnorm(51, mean = 12, sd = 3),
  "bad_yes" = rnorm(51, mean = 10, sd = 3),
  "neutral_yes" = rnorm(51, mean = 16, sd = 3),
  "favorite_yes" = rnorm(51, mean = 25, sd = 3)
) %>%
  rownames_to_column(var = "id") %>%
  pivot_longer(
    cols = -id,
    names_to = c("music_type", "motivation"),
    names_sep = "_",
    names_ptypes = list(music_type = factor(),
                        motivation = factor()),
    values_to = "endurance"
  ) %>%
  mutate(endurance = round(endurance),
         endurance = pmax(endurance, 0),
         endurance = pmin(endurance, 30))

use_data(runners_motivation, overwrite = TRUE)

# Mixed ANOVA
set.seed(20200629)
exam_stress <- tibble(
  before_no = rnorm(48, mean = 35, sd = 4),
  during_no = rnorm(48, mean = 47, sd = 4),
  after_no = rnorm(48, mean = 39, sd = 4),
  before_yes = rnorm(48, mean = 34, sd = 4),
  during_yes = rnorm(48, mean = 20, sd = 4),
  after_yes = rnorm(48, mean = 10, sd = 4)
) %>%
  mutate(
    across(.fns = ~ round(., 0)),
    across(.fns = ~ pmax(., 0)),
    across(.fns = ~ pmin(., 50))
  ) %>%
  pivot_longer(
    cols = everything(),
    names_to = c("time", "preparation"),
    names_sep = "_",
    names_ptype = list(time = factor()),
    values_to = "stress"
  ) %>%
  mutate(
    across(c(time, preparation), str_to_title),
    across(c(time, preparation), as_factor),
    id = rep(1:96, each = 3)
  ) %>%
  relocate(id, preparation, time, stress)

use_data(exam_stress, overwrite = TRUE)


# Faktorenanalyse ---------------------------------------------------------
# EFA
factor_model <- '
anticipation =~ 0.9*item_1 + 0.7*item_4 + 0.6*item_7 + 0.6*item_8 + 0.7*item_12 + 0.8*item_13 + -0.7*item_15
people =~ 0.8*item_2 + -0.7*item_6 + 0.6*item_8 + 0.5*item_9 + 0.9*item_10 + 0.8*item_14
dancing =~ 0.9*item_3 + 0.75*item_5 + 0.8*item_9 + 0.9*item_11 + 0.5*item_14

people ~ 0.2*dancing
anticipation ~ 0.4*people
anticipation ~ 0.4*dancing
'

set.seed(20200703)
party <- lavaan::simulateData(model = factor_model, model.type = "cfa", sample.nobs = 320, ov.var = rep(1.5, times = 15)) %>%
  as_tibble() %>%
  mutate(across(everything(), ~ . + 5),
         # across(everything(), round),
         across(everything(), pmax, 0),
         across(everything(), pmin, 10)
  ) %>%
  select(
    num_range("item_", 1:15)
  ) %>%
  rownames_to_column(var = "id")

use_data(party, overwrite = TRUE)


# CFA
set.seed(20200704)
party_people <- lavaan::simulateData(model = factor_model, model.type = "cfa", sample.nobs = 442, ov.var = rep(1.5, times = 15)) %>%
  as_tibble() %>%
  mutate(across(everything(), ~ . + 5),
         # across(everything(), round),
         across(everything(), pmax, 0),
         across(everything(), pmin, 10)
  ) %>%
  select(
    num_range("item_", 1:15)
  ) %>%
  rownames_to_column(var = "id")

use_data(party_people, overwrite = TRUE)
