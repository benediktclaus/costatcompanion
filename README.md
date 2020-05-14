
# costatcompanion

Der perfekte Begleiter für die [Chamber of
Statistics](https://benediktclaus.github.io/costat/).

In der Chamber of Statistics werden die Umsetzung methodischer
Standard-Verfahren in der Psychologie und den Sozialwissenschaften,
sowie der Medizin im Tidyverse anhand von verständlichen und eingängigen
Beispielen gezeigt.

Das Paket beinhaltet vor allem kleine Hilfs-Funktionen für den
wisschenschaftlichen Alltag in den Sozialwissenschaften und der Medizin,
sowie die Datensätze, die in den Beispielen der Website genutzt werden.

# Installation

Das Paket wird über GitHub vertrieben und gepflegt. Von hier kann man es
direkt in R installieren.

``` r
remotes::install_github("benediktclaus/costatcompanion")

library(costatcompanion)
```

# Datensätze

Ist das Paket geladen, sollten die Datensätze automatisch zur Verfügung
stehen.

``` r
head(ice_cream)
```

    ##   id    flavor    sex yumminess
    ## 1  1 Champagne Female        14
    ## 2  2   Vanilla Female        19
    ## 3  3 Champagne Female        16
    ## 4  4 Chocolate Female        17
    ## 5  5 Chocolate Female        16
    ## 6  6   Vanilla   Male        16
