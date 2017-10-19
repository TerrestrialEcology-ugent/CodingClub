tidyverse-presentation
========================================================
author: Bram Sercu
date: October 19, 2017
autosize: true


The tidyverse ecosystem
========================================================
tidyverse is a set of related packages

![alt text](tidyverse-presentation-figure/tidyverse_1.png)


Part 1: Tidy data
========================================================

Tidy data
========================================================

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



Tibbles
========================================================

- it never changes the type of the inputs (e.g. it never converts strings to factors!)
- it never changes the names of variables 
- it never creates row names.


There are two main differences in the usage of a tibble vs. a classic data.frame: printing and subsetting.

- tibbles print only the first 10 rows and the columns that fit on the screen

piping
========================================================
sequential manipulations of a dataset.

Use '%>%' to connect manipulations







```
Error in eval(expr, envir, enclos) : could not find function "%>%"
```
