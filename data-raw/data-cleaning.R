library(tidyverse)

# Reproducibility Project Psychology
reproducibility_project <- read_rds("data-raw/Reproduceability Project Psychology.rds") %>%
  janitor::clean_names() %>%
  as_tibble() %>%
  select(study_title_o, journal_o, first_author = x1st_author_o, senior_author_o,
         institution_prestige_1st_author_o, institution_prestige_senior_author_o,
         surprising_result_o, exciting_result_o,
         pval_original = t_pval_use_o, pval_replication = t_pval_use_r,
         es_original = t_r_o, es_replication = t_r_r, power_r) %>%
  mutate(
    sig_original = if_else(pval_original <= 0.06, "Significant", "Not Significant"),
    sig_replication = if_else(pval_replication <= 0.05, "Significant", "Not Significant"),
    across(c(sig_original, sig_replication), as_factor),
    across(where(is.character), stringi::stri_trans_general, "latin-ascii"),
    sig_original = fct_relevel(sig_original, "Not Significant")
  )

use_data(reproducibility_project, overwrite = TRUE)

# Placebo Amplification
placebo_amplification <- read_rds("data-raw/placebo_amplification.rds") %>%
  mutate(id = as.character(id),
         measurement = as.numeric(measurement))

use_data(placebo_amplification, overwrite = TRUE)
