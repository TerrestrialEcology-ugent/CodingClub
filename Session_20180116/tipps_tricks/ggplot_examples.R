#some stuff on ggplot

library(ggplot2)
library(dplyr)

head(iris)

#data must be dataframe in ggplot!!!

#website to check: http://ggplot2.tidyverse.org/reference/

?geom_point
#simple scatterplot
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width))+geom_point()
#boxplot
ggplot(iris,aes(x=Species,y=Sepal.Length))+geom_boxplot()
#scatterplot with color
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,color=Species))+geom_point()
#facetting per species
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,color=Petal.Width))+geom_point()+
  facet_grid(~Species)
#add a smoothed line
ggplot(iris) +
  geom_point(aes(x=Sepal.Length,y=Sepal.Width,color=Species))+
  stat_smooth(aes(x=Sepal.Length,y=Sepal.Width,color=Species))
#add a regression line without standard error
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,color=Species))+
  geom_point()+
  stat_smooth(method="lm",se=FALSE)
#histogram
ggplot(iris,aes(x=Sepal.Length,fill=Species))+
  geom_histogram()
#histogram with dodged position
ggplot(iris,aes(x=Sepal.Length,fill=Species))+
  geom_histogram(position="dodge")
#add vertical lines
iris %>%
  group_by(Species) %>%
  summarise(Mean=mean(Sepal.Length),SD=sd(Sepal.Length)) -> mean_df

ggplot(iris,aes(x=Sepal.Length,fill=Species))+
  geom_histogram(position="dodge")+
  geom_vline(data=mean_df,aes(xintercept = Mean,color=Species),size=3,linetype="dashed")

#changing some theme elements
ggplot(iris,aes(x=Sepal.Length,y=Sepal.Width,color=Species))+
  geom_point()+
  stat_smooth(method="lm",se=FALSE) +
  theme(axis.text = element_text(family ="mono",face ="italic",size = 15))

#some stat summary
ggplot(iris,aes(x=Species,y=Sepal.Length))+geom_boxplot()+
  stat_summary(fun.data=mean_se,fun.args=list(mult=2),color="red")

#other stat summary
iris %>%
  group_by(Species)%>%
  summarise(LI=quantile(Sepal.Length,probs=0.01),Mean=mean(Sepal.Length),UI=quantile(Sepal.Length,probs=0.99)) -> mean_2

g1 <- ggplot(iris,aes(x=Species))+
  geom_jitter(aes(y=Sepal.Length))+
  geom_errorbar(data=mean_2,aes(ymin=LI,ymax=UI),color="red",width=0.1)
g1
#some stat functions
me <- mean(iris$Sepal.Length)
sd <- sd(iris$Sepal.Length)

g2 <- ggplot(iris)+
  geom_histogram(aes(x=Sepal.Length,y=..density..,fill=Species))+
  facet_grid(~Species)+
  stat_function(fun=dnorm,args=list(mean=me,sd=sd))

#put several plots together
library(gridExtra)
g_out <- grid.arrange(g1,g2,nrow=2)
ggsave(filename = "ggplot_output.eps",plot = g_out)

#shared legend between different graphs
#define function for combined legend
grid_arrange_shared_legend <- function(..., nrow = 1, ncol = length(list(...)), position = c("bottom", "right")) {
  
  plots <- list(...)
  position <- match.arg(position)
  g <- ggplotGrob(plots[[1]] + theme(legend.position = position))$grobs
  legend <- g[[which(sapply(g, function(x) x$name) == "guide-box")]]
  lheight <- sum(legend$height)
  lwidth <- sum(legend$width)
  gl <- lapply(plots, function(x) x + theme(legend.position = "none"))
  gl <- c(gl, nrow = nrow, ncol = ncol)
  
  combined <- switch(position,
                     "bottom" = arrangeGrob(do.call(arrangeGrob, gl),
                                            legend,
                                            ncol = 1,
                                            heights = unit.c(unit(1, "npc") - lheight, lheight)),
                     "right" = arrangeGrob(do.call(arrangeGrob, gl),
                                           legend,
                                           ncol = 2,
                                           widths = unit.c(unit(1, "npc") - lwidth, lwidth)))
  grid.newpage()
  grid.draw(combined)
  
}

#add italic titles, from Stefano

ggtitle(expression(atop("TITLE", atop(italic("subtitle")))))



#website to check: http://www.ggplot2-exts.org/
