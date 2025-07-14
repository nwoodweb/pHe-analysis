# 11 JULY 2025 - NATHAN WOOD (contact@nwoodweb.xyz)
# Gap Closure Analysis Scripts
# MIT LICENSE

require(ggplot2)
require(dplyr)
require(tidyr)
require(dunn.test)

# import data
gapData <- read.csv('/home/woodn/Desktop/scratchAssay.csv', sep=',')
# gapData$X2 <- gsub(pattern = '8',replacement = '6.9-7.2', gapData$X2)
# gapData$X2 <- gsub(pattern = '7',replacement = '7.3-7.4', gapData$X2)
# gapData$X2 <- gsub(pattern = '6', replacement = '6.5-6.8', gapData$X2)
# gapData$X2 <- gsub(pattern = '5', replacement = '5.5-5.8', gapData$X2)
# gapData$X2 <- gsub(pattern = '3', replacement = '3.5-4.0', gapData$X2)

# reconfigure column names
head(gapData)
columnNames <- c('number','date','filename','pHe','iteration','drug','hour','a','b','percent')
colnames(gapData) <- columnNames

# isolate what we need for pivoting

extracted.data <- data.frame(ph = gapData$pH,
                             hour = gapData$hour,
                             iteration = gapData$iteration,
                             percent = gapData$percent
)

reformed.extracted.data <- extracted.data %>%
  pivot_wider(names_from = iteration, values_from = percent)

colnames(reformed.extracted.data) <- c('pHe','hour','rep1','rep2','rep3','NA')
reformed.extracted.data
reformed.extracted.data.avgstdev <- reformed.extracted.data %>%
  rowwise() %>%
  mutate(average = mean(c(rep1,rep2,rep3), na.rm=T)) %>%
  mutate(stdev = sd(c(rep1,rep2,rep3), na.rm=T)) %>%
  ungroup() 
write.csv(reformed.extracted.data.avgstdev,'/home/woodn/test.csv')
# plot time lapse
plotData <- read.csv('/home/woodn/modify.csv')
ggplot(data = plotData) + 
  geom_point(aes(x=hour,y=average, color = as.factor(pHe),
                 shape = as.factor(pHe), ),
             cex=6, stroke = 1.2)+
  geom_line(aes(x=hour,y=average, color= as.factor(pHe))) + 
  geom_ribbon(aes(x=hour, fill = as.factor(pHe),
                  ymin = average - stdev, ymax = average + stdev),
              alpha=0.34,color='black',width=0.34,stroke=2) + 
  ylim(0,1.10) +
  scale_x_continuous(breaks = seq(0,24,4)) + 
  ylab('Remaining Gap (%)') + 
  xlab('Time (Hours)') + 
  theme_woodn ()


# extract 24 hour points for end point ypothesis testing
extracted.data.24hr

extracted.data.24hr <- subset(extracted.data,extracted.data$hour == '12')
extracted.data.24hr
model <- aov(percent~as.factor(ph), data=extracted.data.24hr)
summary(model)
TukeyHSD(model)
        
        
        dunn.test(x=extracted.data.24hr$percent,g=extracted.data.24hr$ph,)
        
