Back into the tidyverse
========================================================
author: Lionel Hertzog and Bram Sercu
date: September 19, 2018
width: 1440
height: 900


The tidyverse ecosystem
========================================================
tidyverse is a set of related packages

![alt text](tidyverse-presentation-figure/tidyverse_1.png)



Part 1: Tidy data
========================================================

Tidy data
========================================================

At the core of the tidyverse is the concept of **tidy** data

There are three interrelated rules which make a dataset tidy:

- Each variable must have its own column.
- Each observation must have its own row.
- Each value must have its own cell.

simpler set of practical instructions:

- Put each dataset in a tibble.
- Put each variable in a column.


Untidy data
=======================================================

- One variable might be spread across multiple columns.

- One observation might be scattered across multiple rows.


Typically a dataset will only suffer from one of these problems; it’ll only suffer from both if you’re really unlucky! To fix these problems, you’ll need the two most important functions in tidyr: gather() and spread().

Is this a tidy dataset? (1)
=============================================


```
                  Miles_per_gallon Nb_cylinders Displacement
Mazda RX4                     21.0            6          160
Mazda RX4 Wag                 21.0            6          160
Datsun 710                    22.8            4          108
Hornet 4 Drive                21.4            6          258
Hornet Sportabout             18.7            8          360
Valiant                       18.1            6          225
```

Is this a tidy dataset? (2)
========================================


```
    Site     January February    March
1 Site 1  3.31564570 2.853967 12.66853
2 Site 2 12.35968446 4.679603 16.10931
3 Site 3  2.47632616 1.703870 14.22609
4 Site 4 19.38648383 8.337114 14.68847
5 Site 5  0.03838608 8.961834 17.41704
```

Is this a tidy dataset? (3)
=================================


```
           id year month element d1  d2  d3
1 MX000017004 2010     1    TMAX NA  NA  NA
2 MX000017004 2010     1    TMIN NA  NA  NA
3 MX000017004 2010     2    TMAX NA 273 241
4 MX000017004 2010     2    TMIN NA 144 144
5 MX000017004 2010     3    TMAX NA  NA  NA
6 MX000017004 2010     3    TMIN NA  NA  NA
```

Creating tidy data
=======================================================

In tidyr there are **4** main functions:
- (i) gather: put several columns into one


```r
tmp_g <- gather(tmp, key = "Month", value = "Temperature", -Site)
tmp_g
```

```
     Site    Month Temperature
1  Site 1  January  3.31564570
2  Site 2  January 12.35968446
3  Site 3  January  2.47632616
4  Site 4  January 19.38648383
5  Site 5  January  0.03838608
6  Site 1 February  2.85396718
7  Site 2 February  4.67960291
8  Site 3 February  1.70386962
9  Site 4 February  8.33711408
10 Site 5 February  8.96183435
11 Site 1    March 12.66853236
12 Site 2    March 16.10930969
13 Site 3    March 14.22609015
14 Site 4    March 14.68847064
15 Site 5    March 17.41703519
```


Links
- <http://r4ds.had.co.nz/tidy-data.html>

Creating tidy data
=============================================

- (i) gather: put several columns into one
- (ii) spread: put one column into several


```r
(tmp_s <- spread(tmp_g, key = Month , value = Temperature))
```

```
    Site February     January    March
1 Site 1 2.853967  3.31564570 12.66853
2 Site 2 4.679603 12.35968446 16.10931
3 Site 3 1.703870  2.47632616 14.22609
4 Site 4 8.337114 19.38648383 14.68847
5 Site 5 8.961834  0.03838608 17.41704
```

Creating tidy data
=============================

- (i) gather: put several columns into one
- (ii) spread: put one column into several
- (iii) separate: separate values into several columns


```
                   Code Population
1   Gent_OostVlaanderen       1.48
2 Brugge_WestVlaanderen       1.18
3   Antwerpen_Antwerpen       1.82
4       Hasselt_Limburg       0.86
5  Leuven_VlaamsBrabant       1.12
```


```r
(dat_sep <- separate(dat, col = Code, into = c("City", "Province"), sep = "_"))
```

```
       City       Province Population
1      Gent OostVlaanderen       1.48
2    Brugge WestVlaanderen       1.18
3 Antwerpen      Antwerpen       1.82
4   Hasselt        Limburg       0.86
5    Leuven  VlaamsBrabant       1.12
```

Creating tidy data
===============================

- (i) gather: put several columns into one
- (ii) spread: put one column into several
- (iii) separate: separate values into several columns
- (iv) unite: units values from several columns into one


```r
unite(dat_sep, col = "Province/City", Province, City, sep = "/")
```

```
          Province/City Population
1   OostVlaanderen/Gent       1.48
2 WestVlaanderen/Brugge       1.18
3   Antwerpen/Antwerpen       1.82
4       Limburg/Hasselt       0.86
5  VlaamsBrabant/Leuven       1.12
```

Time for some excercices ...

Part 2. dplyr
=========================

dplyr
================

dplyr is used to **manipulate** tidy data, there are five main functions:

- (i) filter: pick observations by their values




```r
filter(mtcars, gear == 4)
```

```
             Type  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
1       Mazda RX4 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
2   Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
3      Datsun 710 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
4       Merc 240D 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
5        Merc 230 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
6        Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
7       Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
8        Fiat 128 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
9     Honda Civic 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
10 Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
11      Fiat X1-9 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
12     Volvo 142E 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```


dplyr
================

dplyr is used to **manipulate** tidy data, there are five main functions:

- (i) filter: pick observations by their values
- (ii) arrange: re-order rows


```r
arrange(mtcars, mpg)
```

```
                  Type  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
1   Cadillac Fleetwood 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
2  Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
3           Camaro Z28 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
4           Duster 360 14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
5    Chrysler Imperial 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
6        Maserati Bora 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
7          Merc 450SLC 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
8          AMC Javelin 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
9     Dodge Challenger 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
10      Ford Pantera L 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
11          Merc 450SE 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
12          Merc 450SL 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
13           Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
14             Valiant 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
15   Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
16            Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
17    Pontiac Firebird 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
18        Ferrari Dino 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
19           Mazda RX4 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
20       Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
21      Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
22          Volvo 142E 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
23       Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
24          Datsun 710 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
25            Merc 230 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
26           Merc 240D 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
27       Porsche 914-2 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
28           Fiat X1-9 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
29         Honda Civic 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
30        Lotus Europa 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
31            Fiat 128 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
32      Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
```

dplyr
================

dplyr is used to **manipulate** tidy data, there are five main functions:

- (i) filter: pick observations by their values
- (ii) arrange: re-order rows
- (iii) select: pick columns




```r
select(mtcars, mpg:disp)
```

```
                     mpg cyl  disp
Mazda RX4           21.0   6 160.0
Mazda RX4 Wag       21.0   6 160.0
Datsun 710          22.8   4 108.0
Hornet 4 Drive      21.4   6 258.0
Hornet Sportabout   18.7   8 360.0
Valiant             18.1   6 225.0
Duster 360          14.3   8 360.0
Merc 240D           24.4   4 146.7
Merc 230            22.8   4 140.8
Merc 280            19.2   6 167.6
Merc 280C           17.8   6 167.6
Merc 450SE          16.4   8 275.8
Merc 450SL          17.3   8 275.8
Merc 450SLC         15.2   8 275.8
Cadillac Fleetwood  10.4   8 472.0
Lincoln Continental 10.4   8 460.0
Chrysler Imperial   14.7   8 440.0
Fiat 128            32.4   4  78.7
Honda Civic         30.4   4  75.7
Toyota Corolla      33.9   4  71.1
Toyota Corona       21.5   4 120.1
Dodge Challenger    15.5   8 318.0
AMC Javelin         15.2   8 304.0
Camaro Z28          13.3   8 350.0
Pontiac Firebird    19.2   8 400.0
Fiat X1-9           27.3   4  79.0
Porsche 914-2       26.0   4 120.3
Lotus Europa        30.4   4  95.1
Ford Pantera L      15.8   8 351.0
Ferrari Dino        19.7   6 145.0
Maserati Bora       15.0   8 301.0
Volvo 142E          21.4   4 121.0
```

dplyr
================

dplyr is used to **manipulate** tidy data, there are five main functions:

- (i) filter: pick observations by their values
- (ii) arrange: re-order rows
- (iii) select: pick columns
- (iv) mutate: create new variables


```r
mutate(mtcars, EFI = mpg * wt)
```

```
    mpg cyl  disp  hp drat    wt  qsec vs am gear carb     EFI
1  21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4 55.0200
2  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4 60.3750
3  22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1 52.8960
4  21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1 68.8010
5  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2 64.3280
6  18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1 62.6260
7  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4 51.0510
8  24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2 77.8360
9  22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2 71.8200
10 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4 66.0480
11 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4 61.2320
12 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3 66.7480
13 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3 64.5290
14 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3 57.4560
15 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4 54.6000
16 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4 56.4096
17 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4 78.5715
18 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1 71.2800
19 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2 49.0960
20 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1 62.2065
21 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1 52.9975
22 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2 54.5600
23 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2 52.2120
24 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4 51.0720
25 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2 73.8240
26 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1 52.8255
27 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2 55.6400
28 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2 45.9952
29 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4 50.0860
30 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6 54.5690
31 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8 53.5500
32 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2 59.4920
```

dplyr
================

dplyr is used to **manipulate** tidy data, there are five main functions:

- (i) filter: pick observations by their values
- (ii) arrange: re-order rows
- (iii) select: pick columns
- (iv) mutate: create new variables
- (v) summarise: collapse many value to a single summary


```r
summarise(mtcars, Mean = mean(mpg), SD = sd(mpg))
```

```
      Mean       SD
1 20.09062 6.026948
```

dplyr
================

dplyr is used to **manipulate** tidy data, there are five main functions:

- (i) filter: pick observations by their values
- (ii) arrange: re-order rows
- (iii) select: pick columns
- (iv) mutate: create new variables
- (v) summarise: collapse many value to a single summary
- (bonus) group_by: to make summarise sooo useful


```r
mt_g <- group_by(mtcars, gear)
summarise(mt_g, Mean = mean(mpg))
```

```
# A tibble: 3 x 2
   gear  Mean
  <dbl> <dbl>
1     3  16.1
2     4  24.5
3     5  21.4
```

dplyr
=========================

Time for some excercices


Part 3. Piping rules
======================

Piping
========================================================

Sequential manipulations of a dataset.

Use '%>%' to connect manipulations


```r
dat
```

```
                   Code Population
1   Gent_OostVlaanderen       1.48
2 Brugge_WestVlaanderen       1.18
3   Antwerpen_Antwerpen       1.82
4       Hasselt_Limburg       0.86
5  Leuven_VlaamsBrabant       1.12
```

```r
dat %>%
  separate(Code, into = c("City","Province"), sep = "_") %>%
  arrange(City)
```

```
       City       Province Population
1 Antwerpen      Antwerpen       1.82
2    Brugge WestVlaanderen       1.18
3      Gent OostVlaanderen       1.48
4   Hasselt        Limburg       0.86
5    Leuven  VlaamsBrabant       1.12
```

Piping
=================================

Different ways to save object after passing through the tidyverse pipe.

- Option 1:


```r
dat_tidied <- dat %>%
  separate(Code, c("City","Province"))%>%
  arrange(City)
```

- Option 2:


```r
dat %>%
  separate(Code, c("City","Province"))%>%
  arrange(City) -> dat_tidied
```


Time for some more advanced exercices !!!


References
========================================================

Book: <http://r4ds.had.co.nz/index.html>

Cheat sheets: <https://www.rstudio.com/resources/cheatsheets/>

Vignette: <https://cran.r-project.org/web/packages/dplyr/dplyr.pdf>


