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


cars %>% as.tibble()



creating tidy data
=======================================================

Four commands
- Gather
- Spread
- separate
- Unite

Links
- <http://r4ds.had.co.nz/tidy-data.html#spreading-and-gathering>
- <http://r4ds.had.co.nz/tidy-data.html#separating-and-uniting>



Part 2: working with your data
========================================================

Subset data
========================================================

Subset observations with  'filter'

- filter(dataset, logical criteria on certain columns)
- use logic operators to set (multiple) criteria
- eg. filter(cars, speed<8)

Subset variables with 'select'
- select(dataset, name of column1, name of column2, ...)
- use helper functions to define the columns more efficiently
  - select(cars, - dist) removes column dist from dataset
  - select(cars, speed:dist) selects all columns between column 'speed' and column 'dist' 


Make new variables
=======================================================

compute and append one or more new columns with 'mutate'
- mutate(dataset, new_column = operation between columns)
- eg. mutate(iris, Sepal.Area = Sepal.Length*Sepal.Width, Sepal.Petal.fraction = Sepal.Length/Petal.Length )
- use functions to calculate more complex measurements
- transmute() works as mutate() but removes the original columns


Summarise data
=======================================================

summarise data into one single row of values

- summarise(iris, avg=mean(Sepal.Length))
- summarise_all(iris, funs(mean))


apply transformations to groups of the data
=======================================================

The function 'group_by' allows you to  define groups in the data
When these grouped dataset is used to summarise or to mutate data,
the transformations are done per group.

- iris %>% group_by(Species) %>% summarise(avg=mean(Sepal.Length))
- iris %>% group_by(Species) %>% summarise_all(funs(mean))
- iris %>% group_by(Species) %>% mutate(Sepal.Length.log=log(Sepal.Length))


Joining datatables
========================================================

lef_join(x, y, by = NULL,
copy=FALSE, suffix=c(“.x”,“.y”),…)
Join matching values from y to x.

right_join(x, y, by = NULL, copy =
FALSE, suffix=c(“.x”,“.y”),…)
Join matching values from x to y.

inner_join(x, y, by = NULL, copy =
FALSE, suffix=c(“.x”,“.y”),…)
Join data. Retain only rows with
matches.

full_join(x, y, by = NULL,
copy=FALSE, suffix=c(“.x”,“.y”),…)
Join data. Retain all values, all rows



References
========================================================

Book: <http://r4ds.had.co.nz/index.html>

Cheat sheets: <https://www.rstudio.com/resources/cheatsheets/>

Vignette: <https://cran.r-project.org/web/packages/dplyr/dplyr.pdf>


