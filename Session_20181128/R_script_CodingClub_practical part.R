library (vegan) # needed for function rda
### Unconstrained ordination
### Example 1: Principal component analysis (PCA) on environmental matrix
### We will use the Carpathian wetlands dataset (Hájek et al.), which contains extensive information about environment, mostly water chemistry. In the following example, we will explore intercorrelated nature of the environmental dataset. 

## import the data into R
##chem <- read.delim ('https://raw.githubusercontent.com/zdealveindy/anadat-r/master/data/chemistry.txt', row.names = 1)
chem <- read.table("pca.data.txt", h = T)
chem <- chem [, -15] # removes slope, which is not chemical variable

### The bojective of this example is to explore the intercorrelated nature of the environmental dataset using the rda funtion from vegan library. 

#### start by standarizing your data 

### Check the results of the analysis using the summary function

### Do you know why the total variation (inertia in the summary object) = 14?

### how much of the total variation the first and the second PCA axes explain? 

### Extract the component loadings / Loading scores of variables and axes using the function "scores"

### Which variables are the most important in explaining PC1 and PC2?

### Draw the diagrams using the function biplot

### How to decide which PCA axis should be used for interpretation of results?

### Re-do the analyses but this time without standarizing the variables and then draw the diagrams.

### What conclusion you get from the biplot

####################################################################
####################################################################
################################## Example 2: using Redundancy Analysis (RDA) and transformed-based RDA
####################################################################
####################################################################

#### Example 2: Use the Vltava river valley dataset; which contains information about species composition (in percentage scale) and environment, mostly soil.

#vltava.spe <- read.delim ('https://raw.githubusercontent.com/zdealveindy/anadat-r/master/data/vltava-spe.txt', row.names = 1)
#vltava.env <- read.delim ('https://raw.githubusercontent.com/zdealveindy/anadat-r/master/data/vltava-env.txt')

vltava.spe<- read.table("vltava.spe.txt", h = T)
vltava.env<- read.table("vltava.env.txt", h = T)

spe <- vltava.spe  # rename variables to make them shorter
env <- vltava.env[, c('pH', 'SOILDPT')]  # select only two explanatory variables
env1 <- vltava.env[,23:28]

spe.log <- log1p (spe)  # species data are in percentage scale which is strongly rightskewed, better to transform them
spe.hell <- decostand (spe.log, 'hell')  # we are planning to do tb-RDA, this is Hellinger pre-transformation

### The objective of this example is to understand the summary of RDA 
### Check wether linear (RDA) or unimodal (CCA) is advisable for the dataset? 
## note that we are going to do the tb-RDA anyway but this is to show how to decide in general whether linear or unimodal ordination methods are more suitable.


# How much variance in species composition can be explained by two variables, soil pH and soil depth (SOILDPT).


#How much of the total variance the first and the second constrained axes could explain?


#How much of the total variance the first unconstrained axis could explain? ??? what does that mean?


#Use the env1 dataset to estimate what may be those environmental variables associated with unconstrained axes???? use the "envfit" function in the "vegan" library


