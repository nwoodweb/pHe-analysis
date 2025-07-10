# 11 JULY 2025 - NATHAN WOOD (contact@nwoodweb.xyz)
# Gap Closure Analysis Scripts
# MIT LICENSE

require(ggplot2)
require(dplyr)
require(tidyr)
require(dunn.test)

# import data
gapData <- read.csv('/data/gap-cariporide-1july25/data/scratchAssay.csv', sep='\t')
gapData

# reconfigure column names

columnNames <- c('number','date','filename','pH','iteration','drug','hour','a','b','percent')
colnames(gapData) <- columnNames

# isolate what we need for pivoting

extracted.data <- data.frame(ph = gapData$pH,
                             hour = gapData$hour,
                             iteration = gapData$iteration,
                             percent = gapData$percent
                             )

reformed.extracted.data <- extracted.data %>%
    pivot_wider(names_from = iteration, values_from = percent)

colnames(reformed.extracted.data) <- c('ph','hour','rep1','rep2','rep3')
reformed.extracted.data.avgstdev <- reformed.extracted.data %>%
    rowwise() %>%
    mutate(average = mean(c(rep1,rep2,rep3), na.rm=T)) %>%
    mutate(stdev = sd(c(rep1,rep2,rep3), na.rm=T)) %>%
    ungroup() 

reformed.extracted.data.avgstdev

ggplot(data = reformed.extracted.data.avgstdev) + 
    geom_point(aes(x=hour,y=average, colour = as.factor(ph)))+
    geom_ribbon(aes(x=hour, fill = as.factor(ph),
                    ymin = average - stdev, ymax = average + stdev),
                alpha=0.5) + 
    ylim(0,100) +
    xlim(0,24) + 
    theme_woodn ()


# extract 24 hour points

extracted.data.24hr <- subset(extracted.data,extracted.data$hour == '24')

dunn.test(extracted.data.24hr$percent,extracted.data.24hr$ph) 
