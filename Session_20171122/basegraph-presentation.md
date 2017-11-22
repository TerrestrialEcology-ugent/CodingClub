<style>
.reveal .state-background {
  background: white;
} 
.reveal pre code {
  font-size: 1em;
}
</style>

R Base Graphics
========================================================
author: 
width: 1500
height: 900
date: 
autosize: false

R graphics systems
========================================================

GrDevices: the R graphics engine, provides infrastructure for:

- "graphics": base graphics
- "grid": newer, includes lattice and ggplot2 (see later this afternoon)

Both work quite differently.

Base graphics pros:
- very flexible, you can make virtually any type of graph, exactly how you want
- good for very quick data visualization

Cons:
- complex graphs are not straightforward, if the graph can be made with ggplot, this will require much less code
- ggplot arguably has more pleasing defaults

R base graphics
========================================================

High-level functions --> complete plots
- plot()
- barplot()
- hist()

Low-level functions --> add to an exisiting plot
- lines()
- points()
- legend()
- text ()

Some do both, via "add=TRUE/FALSE"
- symbols(x,y, ..., add=TRUE)

The plot() function
========================================================

Probably most important function in base graphics

Generic function: does different things with numeric data, factors, matrices, etc.

For example, with x and y numeric, FAC a factor, MAT a matrix:
- plot(x): index plot of x versus its index
- plot(x,y): scatterplot
- plot(FAC, y): boxplot
- plot (x, FAC): stripchart
- plot (FAC,FAC): spineplot, barchart
- plot(MAT): scatterplot matrix

Some examples using plot()
========================================================


```r
head(iris)
```

```
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
```

Index plot
========================================================


```r
plot(iris$Sepal.Length)
```

<img src="basegraph-presentation-figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

Scatterplot
========================================================
<br>

```r
plot(iris$Sepal.Width,iris$Sepal.Length)
```

<img src="basegraph-presentation-figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />
***
This gives same result:

```r
plot(iris$Sepal.Length~iris$Sepal.Width)
```

<img src="basegraph-presentation-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

Boxplot
========================================================


```r
plot(iris$Species,iris$Sepal.Length)
```

<img src="basegraph-presentation-figure/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />

Plot all variables pairwise
========================================================


```r
plot(iris)
```

<img src="basegraph-presentation-figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />
pairs(iris) gives same result

Plot() on linear model object
========================================================


```r
model <- lm(Sepal.Length ~ Sepal.Width,data=iris)
plot(model)
```

![plot of chunk unnamed-chunk-7](basegraph-presentation-figure/unnamed-chunk-7-1.png)![plot of chunk unnamed-chunk-7](basegraph-presentation-figure/unnamed-chunk-7-2.png)![plot of chunk unnamed-chunk-7](basegraph-presentation-figure/unnamed-chunk-7-3.png)![plot of chunk unnamed-chunk-7](basegraph-presentation-figure/unnamed-chunk-7-4.png)

Plot() on PCA
========================================================


```r
pca <- princomp(iris[-5])
plot(pca)
```

<img src="basegraph-presentation-figure/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />
plot(pca) shows a scree plot...

Plot() on PCA
========================================================

For a biplot, use biplot()

```r
biplot(pca)
```

<img src="basegraph-presentation-figure/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />

Some other useful base graphic functions
========================================================

Histograms: hist() function

```r
hist(iris$Sepal.Length)
```

<img src="basegraph-presentation-figure/unnamed-chunk-10-1.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" style="display: block; margin: auto;" />

Some other useful base graphic functions
========================================================

Bar plots: barplot() function

(remember dplyr?)

```r
library(dplyr)
bars <- iris %>% group_by(Species) %>% summarise_all(funs(mean,sd))
barplot(bars$Sepal.Length_mean,names=bars$Species)
```

<img src="basegraph-presentation-figure/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />

Lots of other possibilities...
========================================================

- 3-D plots
- sunflower plots
- mosaic plots
- added variable plots
- effect plots
- maps and spatial visualizations
- trees and network diagrams
- structural equation model graphs

Side note: correlation diagrams
========================================================


```r
library(corrplot)
corrplot(cor(mtcars),method="ellipse")
```

<img src="basegraph-presentation-figure/unnamed-chunk-12-1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" style="display: block; margin: auto;" />

Side note: correlation diagrams
========================================================


```r
corrplot.mixed(cor(mtcars),lower="number",upper="ellipse")
```

<img src="basegraph-presentation-figure/unnamed-chunk-13-1.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" style="display: block; margin: auto;" />

Graphical parameters
========================================================

Some can be set globally, using par() function, e.g.:

- par(mar=c(5.1, 4.1, 4.1, 2.1)): sets margins in order bottom, left, top, right
- par(cex=X): makes text and points X times larger
- par(cex.main=X): makes the main axis title X times larger
- see: ?par() for a full list

Most can be set in plotting functions:
- plot(x, y, cex=2)

NOTE: margins etc. are expressed in lines, par(mai=c()) does the same in inches

Cheat sheet: http://www.gastonsanchez.com/r-graphical-parameters-cheatsheet.pdf

Plot types
========================================================

plot(x ,y ,type="p")
<img src="basegraph-presentation-figure/unnamed-chunk-14-1.png" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" style="display: block; margin: auto;" />

Color, point type, line type
========================================================
<br>

```r
plot(x,y,type="b")
```

<img src="basegraph-presentation-figure/unnamed-chunk-15-1.png" title="plot of chunk unnamed-chunk-15" alt="plot of chunk unnamed-chunk-15" style="display: block; margin: auto;" />
***
<br>

```r
plot(x,y,type="b",col=2,pch=2,lty=2)
```

<img src="basegraph-presentation-figure/unnamed-chunk-16-1.png" title="plot of chunk unnamed-chunk-16" alt="plot of chunk unnamed-chunk-16" style="display: block; margin: auto;" />

Customizing graphs
========================================================

R base graphics works like painting on a canvas  

Each new element is placed on top of the existing graph  

Typically: 
- create basic plot with high-level function
- add elements using low-level function (lines, points, error bars, legends, etc.)

Back to the bar plot...
========================================================

Let's make a grouped bar plot.

Barplot() only takes vectors or matrices with the values to be plotted.

One quick option:

```r
rbind(bars$Sepal.Length_mean,bars$Sepal.Width_mean)
```

```
      [,1]  [,2]  [,3]
[1,] 5.006 5.936 6.588
[2,] 3.428 2.770 2.974
```
Alternatively, for fans of the tidyverse:

```r
library(tidyr)
library(tibble)
groupedbars <- bars %>% select(Species,Sepal.Length_mean,Sepal.Width_mean) %>% gather(Sepal.Length_mean,Sepal.Width_mean,key=sepal_petal,value=length) %>% spread(Species,length) %>% remove_rownames %>% column_to_rownames(var="sepal_petal") %>% as.matrix
groupedbars
```

```
                  setosa versicolor virginica
Sepal.Length_mean  5.006      5.936     6.588
Sepal.Width_mean   3.428      2.770     2.974
```

Back to the bar plot...
========================================================

Let's make a grouped bar plot

```r
barplot(groupedbars,names=colnames(groupedbars))
```

<img src="basegraph-presentation-figure/unnamed-chunk-19-1.png" title="plot of chunk unnamed-chunk-19" alt="plot of chunk unnamed-chunk-19" style="display: block; margin: auto;" />
<br>
This is stacked, nice but not what we want.

Back to the bar plot...
========================================================

Add: beside=TRUE

```r
barplot(groupedbars,names=bars$Species, beside=TRUE)
```

<img src="basegraph-presentation-figure/unnamed-chunk-20-1.png" title="plot of chunk unnamed-chunk-20" alt="plot of chunk unnamed-chunk-20" style="display: block; margin: auto;" />
Better!

Back to the bar plot...
========================================================

Add a legend

```r
barplot(groupedbars, names=bars$Species,
        beside=T, legend=rownames(groupedbars))
```

<img src="basegraph-presentation-figure/unnamed-chunk-21-1.png" title="plot of chunk unnamed-chunk-21" alt="plot of chunk unnamed-chunk-21" style="display: block; margin: auto;" />

Back to the bar plot...
========================================================

Adjust Y-axis limits

```r
barplot(groupedbars, names=bars$Species,
        beside=T, legend=rownames(groupedbars),ylim=c(0,10))
```

<img src="basegraph-presentation-figure/unnamed-chunk-22-1.png" title="plot of chunk unnamed-chunk-22" alt="plot of chunk unnamed-chunk-22" style="display: block; margin: auto;" />

Back to the bar plot...
========================================================

Legend not nice (names of variables). We can just add legend to plot using legend():

```r
barplot(groupedbars, names=bars$Species, beside=T, ylim=c(0,10))
legend("topright",c("Sepal length","Sepal width"),fill=gray.colors(2))
```

<img src="basegraph-presentation-figure/unnamed-chunk-23-1.png" title="plot of chunk unnamed-chunk-23" alt="plot of chunk unnamed-chunk-23" style="display: block; margin: auto;" />
<br>
gray.colors(x) is the range of colors used by default by barplot(), with x = number of colors.  
Legend() also takes coordinates for placement, other symbols, hex colors, etc.


Back to the bar plot...
========================================================


```r
bplot <- barplot(groupedbars, names=bars$Species,beside=T, ylim=c(0,10))
legend("topleft",c("Sepal length","Sepal width"),fill=gray.colors(2))
arrows(bplot[1,],bars$Sepal.Length_mean,bplot[1,],bars$Sepal.Length_mean+
  bars$Sepal.Length_sd,code=2,angle=90,length=0.05)
arrows(bplot[2,],bars$Sepal.Width_mean,bplot[2,],bars$Sepal.Width_mean+
  bars$Sepal.Width_sd,code=2,angle=90,length=0.05)
```

<img src="basegraph-presentation-figure/unnamed-chunk-24-1.png" title="plot of chunk unnamed-chunk-24" alt="plot of chunk unnamed-chunk-24" style="display: block; margin: auto;" />
How about some error bars...

Back to the scatterplot...
========================================================

Add a main title, change axis titles

```r
plot(iris$Sepal.Length~iris$Sepal.Width, main="Iris sepal dimensions",xlab="Sepal width",ylab="Sepal length")
```

<img src="basegraph-presentation-figure/unnamed-chunk-25-1.png" title="plot of chunk unnamed-chunk-25" alt="plot of chunk unnamed-chunk-25" style="display: block; margin: auto;" />
Back to the scatterplot...
========================================================

Remove box

```r
plot(iris$Sepal.Length~iris$Sepal.Width, main="Iris sepal dimensions",xlab="Sepal width",ylab="Sepal length",bty="l")
```

<img src="basegraph-presentation-figure/unnamed-chunk-26-1.png" title="plot of chunk unnamed-chunk-26" alt="plot of chunk unnamed-chunk-26" style="display: block; margin: auto;" />
Back to the scatterplot...
========================================================

For fun, let's build this from scratch...

```r
plot.new()
plot.window(xlim=range(iris$Sepal.Width),ylim=range(iris$Sepal.Length))
box(bty="l")
```

<img src="basegraph-presentation-figure/unnamed-chunk-27-1.png" title="plot of chunk unnamed-chunk-27" alt="plot of chunk unnamed-chunk-27" style="display: block; margin: auto;" />

Back to the scatterplot...
========================================================

For fun, let's build this from scratch...

```r
plot.new()
plot.window(xlim=range(iris$Sepal.Width),ylim=range(iris$Sepal.Length))
box(bty="l")
axis(1)
axis(2)
```

<img src="basegraph-presentation-figure/unnamed-chunk-28-1.png" title="plot of chunk unnamed-chunk-28" alt="plot of chunk unnamed-chunk-28" style="display: block; margin: auto;" />

Back to the scatterplot...
========================================================

For fun, let's build this from scratch...

```r
plot.new()
plot.window(xlim=range(iris$Sepal.Width),ylim=range(iris$Sepal.Length))
box(bty="l")
axis(1)
axis(2)
points(iris$Sepal.Width,iris$Sepal.Length)
```

<img src="basegraph-presentation-figure/unnamed-chunk-29-1.png" title="plot of chunk unnamed-chunk-29" alt="plot of chunk unnamed-chunk-29" style="display: block; margin: auto;" />

Back to the scatterplot...
========================================================

For fun, let's build this from scratch...

```r
plot.new()
plot.window(xlim=range(iris$Sepal.Width),ylim=range(iris$Sepal.Length))
box(bty="l")
axis(1)
axis(2)
points(iris$Sepal.Width,iris$Sepal.Length)
title(main="Iris sepal dimensions",xlab="Sepal width",ylab="Sepal length")
```

<img src="basegraph-presentation-figure/unnamed-chunk-30-1.png" title="plot of chunk unnamed-chunk-30" alt="plot of chunk unnamed-chunk-30" style="display: block; margin: auto;" />

Back to the scatterplot...
========================================================

Now much more customizable. E.g. increase distance from ticks to labels of Y-axis

```r
plot.new()
plot.window(xlim=range(iris$Sepal.Width),ylim=range(iris$Sepal.Length))
box(bty="l")
axis(1)
axis(2,padj=-1.5)
points(iris$Sepal.Width,iris$Sepal.Length)
title(main="Iris sepal dimensions",xlab="Sepal width",ylab="Sepal length")
```

<img src="basegraph-presentation-figure/unnamed-chunk-31-1.png" title="plot of chunk unnamed-chunk-31" alt="plot of chunk unnamed-chunk-31" style="display: block; margin: auto;" />

Back to the scatterplot...
========================================================

Now much more customizable. Make Y-axis ticks longer. Possibilities = endless.

```r
plot.new()
plot.window(xlim=range(iris$Sepal.Width),ylim=range(iris$Sepal.Length))
box(bty="l")
axis(1)
axis(2,padj=-1.5,tcl=-1)
points(iris$Sepal.Width,iris$Sepal.Length)
title(main="Iris sepal dimensions",xlab="Sepal width",ylab="Sepal length")
```

<img src="basegraph-presentation-figure/unnamed-chunk-32-1.png" title="plot of chunk unnamed-chunk-32" alt="plot of chunk unnamed-chunk-32" style="display: block; margin: auto;" />

Back to the scatterplot...
========================================================

A few other useful things, trendline:

```r
plot(iris$Sepal.Length~iris$Sepal.Width, main="Iris sepal dimensions",xlab="Sepal width",ylab="Sepal length",bty="l")
abline(lm(iris$Sepal.Length~iris$Sepal.Width))
```

<img src="basegraph-presentation-figure/unnamed-chunk-33-1.png" title="plot of chunk unnamed-chunk-33" alt="plot of chunk unnamed-chunk-33" style="display: block; margin: auto;" />

Back to the scatterplot...
========================================================

Sometimes you want a reference level:

```r
plot(iris$Sepal.Length~iris$Sepal.Width, main="Iris sepal dimensions",xlab="Sepal width",ylab="Sepal length",bty="l")
abline(h=5,col="red")
text(4.1,4.9, "Sepals are 5 mm long",col="red")
```

<img src="basegraph-presentation-figure/unnamed-chunk-34-1.png" title="plot of chunk unnamed-chunk-34" alt="plot of chunk unnamed-chunk-34" style="display: block; margin: auto;" />

Back to the scatterplot...
========================================================

We can group by species:

```r
plot(iris$Sepal.Length, iris$Sepal.Width, col=iris$Species)
legend("topright",levels(iris$Species),col=1:length(iris$Species),pch=1)
```

<img src="basegraph-presentation-figure/unnamed-chunk-35-1.png" title="plot of chunk unnamed-chunk-35" alt="plot of chunk unnamed-chunk-35" style="display: block; margin: auto;" />

Back to the scatterplot...
========================================================

Change colors if you like:

```r
palette(c("blue","green","pink"))
plot(iris$Sepal.Length, iris$Sepal.Width, col=iris$Species)
legend("topright",levels(iris$Species),col=1:length(iris$Species),pch=1)
```

<img src="basegraph-presentation-figure/unnamed-chunk-36-1.png" title="plot of chunk unnamed-chunk-36" alt="plot of chunk unnamed-chunk-36" style="display: block; margin: auto;" />
<br>
Of course you could also build from scratch and add two sets of points.

Add lines to a plot
========================================================

R knows how to plot time series data:

```r
plot(lynx)
```

<img src="basegraph-presentation-figure/unnamed-chunk-37-1.png" title="plot of chunk unnamed-chunk-37" alt="plot of chunk unnamed-chunk-37" style="display: block; margin: auto;" />

Add lines to a plot
========================================================

Suppose regular format:

```r
newlynx <- as.data.frame(lynx)
newlynx$year <- c(1821:1934)
colnames(newlynx)[1] <- "lynx"

plot(newlynx$year,newlynx$lynx)
```

<img src="basegraph-presentation-figure/unnamed-chunk-38-1.png" title="plot of chunk unnamed-chunk-38" alt="plot of chunk unnamed-chunk-38" style="display: block; margin: auto;" />

Add lines to a plot
========================================================

Add lines:

```r
newlynx <- as.data.frame(lynx)
newlynx$year <- c(1821:1934)
colnames(newlynx)[1] <- "lynx"

plot(newlynx$year,newlynx$lynx)
lines(lynx~year,data=newlynx,col="gray")
```

<img src="basegraph-presentation-figure/unnamed-chunk-39-1.png" title="plot of chunk unnamed-chunk-39" alt="plot of chunk unnamed-chunk-39" style="display: block; margin: auto;" />

Multipanel plots
========================================================

One approach:

```r
par(mfrow=c(2,2))
plot(iris$Sepal.Width,iris$Sepal.Length)
plot(iris$Species,iris$Sepal.Length)
hist(iris$Sepal.Length)
hist(iris$Sepal.Width)
```

<img src="basegraph-presentation-figure/unnamed-chunk-40-1.png" title="plot of chunk unnamed-chunk-40" alt="plot of chunk unnamed-chunk-40" style="display: block; margin: auto;" />

Multipanel plots
========================================================

Suppose only 3 plots:

```r
par(mfrow=c(2,2))
plot(iris$Sepal.Width,iris$Sepal.Length)
plot(iris$Species,iris$Sepal.Length)
hist(iris$Sepal.Length)
```

<img src="basegraph-presentation-figure/unnamed-chunk-41-1.png" title="plot of chunk unnamed-chunk-41" alt="plot of chunk unnamed-chunk-41" style="display: block; margin: auto;" />

Multipanel plots
========================================================

More flexible: layout()

```r
layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE))
plot(iris$Sepal.Width,iris$Sepal.Length)
plot(iris$Species,iris$Sepal.Length)
hist(iris$Sepal.Length)
```

<img src="basegraph-presentation-figure/unnamed-chunk-42-1.png" title="plot of chunk unnamed-chunk-42" alt="plot of chunk unnamed-chunk-42" style="display: block; margin: auto;" />

Multipanel plots
========================================================

More flexible: layout()

```r
layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE),widths=c(2,1), heights=c(3,2))
plot(iris$Sepal.Width,iris$Sepal.Length)
plot(iris$Species,iris$Sepal.Length)
hist(iris$Sepal.Length)
```

<img src="basegraph-presentation-figure/unnamed-chunk-43-1.png" title="plot of chunk unnamed-chunk-43" alt="plot of chunk unnamed-chunk-43" style="display: block; margin: auto;" />

Exporting to .eps files
========================================================

Journals often ask .eps file for vectorial graphs.  
You can set the dimensions of the file in postscript().

```r
setEPS()
postscript("nice eps file.eps",width=5,height=5)
layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE),widths=c(2,1), heights=c(3,2))
plot(iris$Sepal.Width,iris$Sepal.Length)
plot(iris$Species,iris$Sepal.Length)
hist(iris$Sepal.Length)
dev.off()
```
R only uses Helvetica, Times, and Courier as fonts for postscript files.
Solution: package "extrafont"

```r
install.packages("extrafont")
library(extrafont)
font_import()
```
Then before plot code, use:

```r
library(extrafont)
loadfonts(device="postscript")
```

Mind the margins
========================================================


```r
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE),widths=c(1,1), heights=c(1,1))
plot(iris$Sepal.Width,iris$Sepal.Length)
plot(iris$Petal.Width,iris$Sepal.Length)
plot(iris$Sepal.Width,iris$Petal.Length)
plot(iris$Petal.Width,iris$Petal.Length)
```

<img src="basegraph-presentation-figure/unnamed-chunk-47-1.png" title="plot of chunk unnamed-chunk-47" alt="plot of chunk unnamed-chunk-47" style="display: block; margin: auto;" />

Remove redundant axis labels
========================================================


```r
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE),widths=c(1,1), heights=c(1,1))
plot(iris$Sepal.Width,iris$Sepal.Length,xlab='')
plot(iris$Petal.Width,iris$Sepal.Length,xlab='',ylab='')
plot(iris$Sepal.Width,iris$Petal.Length)
plot(iris$Petal.Width,iris$Petal.Length,ylab='')
```

<img src="basegraph-presentation-figure/unnamed-chunk-48-1.png" title="plot of chunk unnamed-chunk-48" alt="plot of chunk unnamed-chunk-48" style="display: block; margin: auto;" />

Bring plots closer together (decrease bottom margin)
========================================================


```r
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE),widths=c(1,1), heights=c(1,1))
par(mar=c(2, 4, 4, 2))
plot(iris$Sepal.Width,iris$Sepal.Length,xlab='')
plot(iris$Petal.Width,iris$Sepal.Length,xlab='',ylab='')
plot(iris$Sepal.Width,iris$Petal.Length)
plot(iris$Petal.Width,iris$Petal.Length,ylab='')
```

<img src="basegraph-presentation-figure/unnamed-chunk-49-1.png" title="plot of chunk unnamed-chunk-49" alt="plot of chunk unnamed-chunk-49" style="display: block; margin: auto;" />
<br>
Looks better, but now labels fall outside the bottom margin.

Make bottom margin of last two figures big again
========================================================


```r
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE),widths=c(1,1), heights=c(1,1))
par(mar=c(2, 4, 4, 2))
plot(iris$Sepal.Width,iris$Sepal.Length,xlab='')
plot(iris$Petal.Width,iris$Sepal.Length,xlab='',ylab='')
par(mar=c(5, 4, 4, 2))
plot(iris$Sepal.Width,iris$Petal.Length)
plot(iris$Petal.Width,iris$Petal.Length,ylab='')
```

<img src="basegraph-presentation-figure/unnamed-chunk-50-1.png" title="plot of chunk unnamed-chunk-50" alt="plot of chunk unnamed-chunk-50" style="display: block; margin: auto;" />
<br>
Now the labels are back, but four figures squeezed into identical-sized matrix cells

Solution: define widths and heights exactly, and adjust margins
========================================================

However:
- layout() uses cm
- par(mar) uses lines
- par(mai) uses inches

5 lines = 1 inch = 2.54 cm  

Note: layout changes number of lines per inch depending on number of rows and columns.  
This behavior can be undone with  a "par(cex=1)" then "par(mar=c(.,.,.,.))" statement after the layout() statement.

Safest bet: convert everything to inches or cm for consistent results (use par(mai))

Solution
========================================================


```r
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE),widths=c(lcm(3*2.54),lcm(3*2.54)),heights=c(lcm(3*2.54),lcm((3+0.5)*2.54)))
par(mai=c(0.2, 0.7, 0.4, 0))
plot(iris$Sepal.Width,iris$Sepal.Length,xlab='')
plot(iris$Petal.Width,iris$Sepal.Length,xlab='',ylab='')
par(mai=c(0.7, 0.7, 0.4, 0))
plot(iris$Sepal.Width,iris$Petal.Length)
plot(iris$Petal.Width,iris$Petal.Length,ylab='')
```

<img src="basegraph-presentation-figure/unnamed-chunk-51-1.png" title="plot of chunk unnamed-chunk-51" alt="plot of chunk unnamed-chunk-51" style="display: block; margin: auto;" />


