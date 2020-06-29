#' Water Park Data
#'
#' A dataset containing different dependent variables measured on 100 different
#' days in a random water park. This was used as an example for correlation
#' analyses.
#'
#' @format A data frame with 100 rows and 5 variables.
#
#' \describe{
#'     \item{\code{day_id}}{A uniqe identifier of observed days}
#'     \item{\code{temperature}}{Day's temperature}
#'     \item{\code{swimmers}}{Day's swimmers/guests}
#'     \item{\code{sales}}{Day's sales}
#'     \item{\code{beatings}}{Observed beatings}
#' }
#'
#' @source Fictional dataset
#'
"water_park"

#' Speed and Accuracy Data
#'
#' A dataset containing speed and accuracy data for 87 participants trying to
#' type as fast as they can. This was used as an example for repeated measures
#' correlation (rmcorr)
#'
#' @format A data frame with 435 rows and 4 variables.
#'
#' \describe{
#'     \item{\code{id}}{Participant's ID}
#'     \item{\code{trial}}{Trial}
#'     \item{\code{speed}}{Participant's typing speed in keystrokes per minute}
#'     \item{\code{accuracy}}{Participant's accuracy in percent with 100 indicating that no mistakes were made}
#' }
#'
#' @source Fictional dataset
#'
"typing"

#' Placebo Amplification Data
#'
#' A dataset containing data from a randomized clinical trial sought to amplify
#' the placebo effect of antidepressants for 43 participants. This was used as a
#' real world example for repeated measures corrlation.
#'
#' @format A data frame with 172 rows and 13 variables.
#' \describe{
#'     \item{\code{id}}{Participant's age}
#'     \item{\code{age}}{Age}
#'     \item{\code{sex}}{Sex, a factor with two levels ("Female" or "Male")}
#'     \item{\code{treatment}}{The randomly assigned treatment, a factor with two levels ("TAU" = treatment as usual or "EG" = experimental group)}
#'     \item{\code{measurement}}{Number of measurement}
#'     \item{\code{exp_size}}{Participant's expected size of the improvement due to the antidepressant}
#'     \item{\code{exp_certain}}{Participant's expected certainty of an improvement due to the antidepressant}
#'     \item{\code{exp_speed}}{Participant's expected speed of the improvement due to the antidepressant}
#'     \item{\code{cgi_s}}{Clinical Global Impressions, severity score}
#'     \item{\code{bdi}}{Beck's Depression Inventory score}
#'     \item{\code{shaps}}{Snaith-Hamilton Pleasure Scale score}
#'     \item{\code{who}}{WHO Well-Being Questionnaire score}
#'     \item{\code{hamd}}{Hamilton Rating Scale for Depression score}
#' }
#'
#' @source \href{https://www.karger.com/Article/Abstract/505855}{Claus, B. B., Scherbaum, N., & Bonnet, U. (2020).
#' Effectiveness of an Adjunctive Psychotherapeutic Intervention Developed for Enhancing the Placebo Effect of
#' Antidepressants Used within an Inpatient-Treatment Program of Major Depression: A Pragmatic Parallel-Group,
#' Randomized Controlled Trial. Psychotherapy and Psychosomatics, 1-3. https://doi.org/10.1159/000505855}
#'
"placebo_amplification"

#' Intelligence ratings of Ravenclaw's
#'
#' A dataset containing intelligence ratings for 48 members of the Hogwarts
#' house of Ravenclaw. This was used as an example for a one-sample t-Test.
#'
#' @format A data frame with 49 rows and 2 variables.
#'
#' \describe{
#'     \item{\code{id}}{Participant's ID}
#'     \item{\code{intelligence}}{Participant's
#'   intelligence}
#' }
#'
#' @source Fictional dataset.
#'
"ravenclaw"


#' Chivalry ratings of Gryffindor's and Slytherin's
#'
#' A dataset containing chivalry ratings for 80 members of the Hogwarts houses
#' Gryffindor and Slytherin. This was used as an example for an independent
#' t-Test.
#'
#' @format A data frame with 80 rows and 3 variables.
#'
#' \describe{
#'   \item{\code{id}}{Participant's ID}
#'   \item{\code{house}}{Participant's house}
#'   \item{\code{chivalry}}{Participant's chivalry rating}
#' }
#'
#' @source Fictional dataset.
"chivalry"


#' Patience ratings of Hufflepuffs
#'
#' A dataset containing patience ratings for 106 members of the Hogwarts
#' houseHufflepuff. This was used as an example for a dependent t-Test.
#'
#' @format A data frame with 106 rows and 3 variables.
#'
#' \describe{
#'   \item{\code{id}}{Participant's ID}
#'   \item{\code{measurement}}{Time of measurement in relation to the school year}
#'   \item{\code{patience}}{Participant's patience}
#' }
#'
#' @source Fictional dataset.
"patience"


#' Joy of Phantasialand's visitors
#'
#' A dataset containing joy ratings for 186 visitors of the Phantasialand. This
#' was used as an example dataset for a one-way ANOVA.
#'
#' @format A data frame with 186 rows and 3 variables.
#'
#' \describe{
#'   \item{\code{id}}{Participant's ID}
#'   \item{\code{backpack}}{Participant's backpack}
#'   \item{\code{joy}}{Participant's joy}
#' }
#'
#' @source Fictional dataset.
"phantasialand"


#' Yumminessof different ice cream flavors
#'
#' A dataset containing yumminess ratings of 295 voluntary tasters for different
#' ice cream flavors. This was used as an example dataset for a factorial ANOVA.
#'
#' @format A data frame with 295 rows and 4 variables.
#'
#' \describe{
#'   \item{\code{id}}{Participant's ID}
#'   \item{\code{flavor}}{Ice cream flavor}
#'   \item{\code{sex}}{Participant's sex}
#'   \item{\code{yumminess}}{Ice cream's yumminess}
#' }
#'
#' @source Fictional dataset.
"ice_cream"

#' Perceived endurance of runners
#'
#' A dataset containing endurance ratings of 51 voluntary runners, running while
#' listening to different types of music. This was used as an example dataset
#' for a one-way repeated measures ANOVA.
#'
#' @format A data frame with 153 rows and 3 variables.
#'
#' \describe{
#'   \item{\code{id}}{Participant's ID}
#'   \item{\code{music_type}}{Type of music listened to}
#'   \item{\code{endurance}}{Participant's perceived endurance}
#' }
#'
#' @source Fictional dataset.
"runners"

#' Perceived endurance of runners
#'
#' A dataset containing endurance ratings of 51 voluntary runners, running while
#' listening to different types of music while motivated or not. This was used
#' as an example dataset for a two-way repeated measures ANOVA.
#'
#' @format A data frame with 153 rows and 4 variables.
#'
#' \describe{
#'   \item{\code{id}}{Participant's ID}
#'   \item{\code{music_type}}{Type of music listened to}
#'   \item{\code{motivation}}{Did the runner have motivation for that run?}
#'   \item{\code{endurance}}{Participant's perceived endurance}
#' }
#'
#' @source Fictional dataset.
"runners_motivation"

#' Reproducibility Poject Psychology
#'
#' A dataset containing a reduced version of the original published dataset for
#' the ingenious project by the Open Science Collaboration.
#'
#' @format A data frame with 168 rows and 15 variables.
#'
#' \describe{
#'     \item{\code{study_title_o}}{Original study's title}
#'     \item{\code{journal_o}}{Journal}
#'     \item{\code{first_author}}{First author}
#'     \item{\code{senior_author_o}}{Senior author}
#'     \item{\code{institution_prestige_1st_author_o}}{First author's institution prestige}
#'     \item{\code{institution_prestige_senior_author_o}}{Senior author's institution prestige}
#'     \item{\code{surprising_result_o}}{Surprising result? (see original codebook for more details)}
#'     \item{\code{exciting_result_o}}{Exciting result? (see original codebook for more details)}
#'     \item{\code{pval_original}}{p-value in original study}
#'     \item{\code{pval_replication}}{p-value in replication study}
#'     \item{\code{es_original}}{Effect size (r) in original study}
#'     \item{\code{es_replication}}{Effect size (r) in replication study}
#'     \item{\code{power_r}}{Power in replication study}
#'     \item{\code{sig_original}}{Indicator, if p was significant in original study (Note: three studies had a p between .05 and .06. Those were countas as significant as well)}
#'     \item{\code{sig_replication}}{Indicator, if p was significant in replication study}
#' }
#'
#' @source \href{https://osf.io/ezcuj}{Open Science Framework repository of the original study.}
"reproducibility_project"

#' Exam Stress
#'
#' A dataset containing stress levels for 96 participants before, during and
#' after an exam, split by whether they prepared or did not prepare for this
#' exam. This was used as an example for a mixed ANOVA.
#'
#' @format A data frame containing 288 rows and 4 variables.
#' \describe{
#'     \item{\code{id}}{Participant's ID}
#'     \item{\code{preparation}}{Factor indicating whether a student prepared for the exam or not}
#'     \item{\code{time}}{Factor indicating time of stress measurement}
#'     \item{\code{stress}}{Observed stress level on a scale vom 0 (lowest) to 50 (highest)}
#' }
#'
#' @source Fictional dataset

"exam_stress"
