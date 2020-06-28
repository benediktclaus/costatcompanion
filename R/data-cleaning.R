library(tidyverse)

reproducibility_import <- read_rds("data-raw/Reproduceability Project Psychology.rds") %>% janitor::clean_names() %>% as_tibble()

reproducibility_project <- reproducibility_import %>%
  select(study_title_o, journal_o, first_author = x1st_author_o, senior_author_o,
         institution_prestige_1st_author_o, institution_prestige_senior_author_o,
         surprising_result_o, exciting_result_o,
         pval_original = t_pval_use_o, pval_replication = t_pval_use_r,
         es_original = t_r_o, es_replication = t_r_r, power_r) %>%
  mutate(
    sig_original = if_else(pval_original <= 0.06, "Significant", "Not Significant"),
    sig_replication = if_else(pval_replication <= 0.05, "Significant", "Not Significant"),
    across(c(sig_original, sig_replication), as_factor)
  )

use_data(reproducibility_project, overwrite = TRUE)
