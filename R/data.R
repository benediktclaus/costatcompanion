#' Water Park Data
#'
#' A dataset containing different dependent variables measured on 100 different
#' days in a random water park. This was used as an example for correlation
#' analyses.
#'
#' @format A data frame with 100 rows and 5 variables.
#'
#' \describe{
#'     \item{day_id}{A uniqe identifier of observed days}
#'     \item{temperature}{Day's temperature}
#'     \item{swimmers}{Day's swimmers/guests}
#'     \item{sales}{Day's sales}
#'     \item{beatings}{Observed beatings}
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
#' @format A data frame with 435 rows and 3 variables
#'
#' \describe{
#'     \item{id}{Participant's ID}
#'     \item{speed}{Participant's typing speed in keystrokes per minute}
#'     \item{accuracy}{Participant's accuracy in percent with 100 indicating that no mistakes were made}
#' }
#'
"typing"

#' Intelligence ratings of Ravenclaw's
#'
#' A dataset containing intelligence ratings for 48 members of the Hogwarts
#' house of Ravenclaw. This was used as an example for a one-sample t-Test.
#'
#' @format A data frame with 49 rows and 2 variables.
#'
#' \describe{
#'     \item{id}{Participant's ID}
#'     \item{intelligence}{Participant's
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
#'   \item{id}{Participant's ID}
#'   \item{house}{Participant's house}
#'   \item{chivalry}{Participant's chivalry rating}
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
#'   \item{id}{Participant's ID}
#'   \item{measurement}{Time of measurement in relation to the school year}
#'   \item{patience}{Participant's patience}
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
#'   \item{id}{Participant's ID}
#'   \item{backpack}{Participant's backpack}
#'   \item{joy}{Participant's joy}
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
#'   \item{id}{Participant's ID}
#'   \item{flavor}{Ice cream flavor}
#'   \item{sex}{Participant's sex}
#'   \item{yumminess}{Ice cream's yumminess}
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
#'   \item{id}{Participant's ID}
#'   \item{music_type}{Type of music listened to}
#'   \item{endurance}{Participant's perceived endurance}
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
#'   \item{id}{Participant's ID}
#'   \item{music_type}{Type of music listened to}
#'   \item{motivation}{Did the runner have motivation for that run?}
#'   \item{endurance}{Participant's perceived endurance}
#' }
#'
#' @source Fictional dataset.
"runners_motivation"
