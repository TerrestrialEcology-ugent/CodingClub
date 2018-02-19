#challenge BattleViz
library(ggplot2)
library(dplyr)
library(png)
library(gtable)

#load the data
dat <- read.csv("Documents/PostDoc_Ghent/Course/CodingClub/CodingClub_UGent/Session_20180116/data/Challenge_data.csv")

dat$Light_Intensity <- factor(dat$Light_Intensity)

ll <- levels(dat$Species) 
ll <- gsub("_"," ",ll)
ll <- gsub("(\\w*) (\\w*).*","\\1 \\2",ll)
levels(dat$Species) <- ll

#get average division rates across species
dat %>%
  group_by(Species) %>%
  mutate(M=mean(Division)) %>%
  mutate(Temp_sh = ifelse(Light_Intensity == 2500,Temperature - 1,Temperature + 1))-> dat_dd

img <- readPNG("Desktop/chl.png")

p <- ggplot(dat_dd,aes(x=Temp_sh,y=Division,color=Light_Intensity)) +
  geom_point() +
  #geom_smooth(aes(group=Light_Intensity),se=FALSE) +
  facet_wrap(~Species) +
  geom_hline(aes(yintercept=M)) +
  geom_linerange(aes(ymin=M,ymax=Division),linetype="dashed") +
  labs(title="Division rates of 19 alguae species across temperature and light intensity",
       y="Division rates [proportional increase in cell numbers]",
       x="Temperature [°C]") +
  theme(panel.background = element_rect(fill="darkseagreen1"),panel.grid = element_line(size=0),
        strip.background = element_rect(fill="darkgreen"),strip.text = element_text(color="white")) +
  scale_color_manual(values=c("seagreen4","yellow3"),name="Light\nintensity [lux]")

g <- ggplotGrob(p)

g <- gtable_add_grob(g, rasterGrob(img), nrow(g)-4, ncol(g)-5)
ggsave("BattleViz.eps",plot=g,width=10,height=6,units = "in",dpi=100)
