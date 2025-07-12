# 11 JULY 2025 - NATHAN WOOD (contact@nwoodweb.xyz)
    # Gap Closure Analysis Scripts
    # MIT LICENSE
    
    require(ggplot2)
require(dplyr)
require(tidyr)
require(dunn.test)

    # import data
    gapData <- read.csv('/data/gap-cariporide-1july25/data/scratchAssay.csv', sep=',')

    # reconfigure column names
    
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

    colnames(reformed.extracted.data) <- c('pHe','hour','rep1','rep2','rep3')
reformed.extracted.data.avgstdev <- reformed.extracted.data %>%
    rowwise() %>%
    mutate(average = mean(c(rep1,rep2,rep3), na.rm=T)) %>%
    mutate(stdev = sd(c(rep1,rep2,rep3), na.rm=T)) %>%
    ungroup() 

    
    # plot time lapse
    ggplot(data = reformed.extracted.data.avgstdev) + 
        geom_point(aes(x=hour,y=average, colour = as.factor(pHe)))+
        geom_line(aes(x=hour,y=average, color= as.factor(pHe))) + 
        geom_ribbon(aes(x=hour, fill = as.factor(pHe),
                        ymin = average - stdev, ymax = average + stdev),
    alpha=0.5,color='black') + 
        ylim(0,1.10) +
        scale_x_continuous(breaks = seq(0,24,4)) + 
        ylab('Remaining Gap (%)') + 
        xlab('Time (Hours)') + 
        theme_woodn ()
    
        
        # extract 24 hour points for end point ypothesis testing
        
        
        extracted.data.24hr <- subset(extracted.data,extracted.data$hour == '24')
    extracted.data.24hr
    model <- aov(ph~percent, data=extracted.data.24hr)
    summary(model
            TukeyHSD(model)
    
        
        dunn.test(x=extracted.data$percent,g=extracted.data$ph)
    
