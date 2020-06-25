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
