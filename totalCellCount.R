# 8 JULY 2028 WOOD-NT contact@nwoodweb.xyz
# ANALYSIS AND PLOT FOR TOTAL CELL COUNT AND PH
# MIT LICENSE

require(ggplot2)
require(dplyr)
require(dunn.test)

# load each iteration
iteration1 <- read.csv('/data/phViable/data/iteration-1.csv')
iteration2 <- read.csv('/data/phViable/data/iteration-2.csv')
iteration3 <- read.csv('/data/phViable/data/iteration-3.csv')

# remove extraneous characters from pH column

iteration1$ph <- gsub('-','',iteration1$ph)
iteration2$ph <- gsub('-','',iteration2$ph)
iteration3$ph <- gsub('-','',iteration3$ph)

iteration1$ph <- gsub('_','',iteration1$ph)
iteration2$ph <- gsub('_','',iteration2$ph)
iteration3$ph <- gsub('_','',iteration3$ph)

# remove extraneous characters from iteration column

iteration1$iteration <- gsub('-','',iteration1$iteration)
iteration2$iteration <- gsub('-','',iteration2$iteration)
iteration3$iteration <- gsub('-','',iteration3$iteration)

iteration1$iteration <- gsub('_','',iteration1$iteration)
iteration2$iteration <- gsub('_','',iteration2$iteration)
iteration3$iteration <- gsub('_','',iteration3$iteration)

# separate into time points 

iteration1.1hr <- subset(iteration1,iteration1$hour == '1')
iteration2.1hr <- subset(iteration2,iteration2$hour == '1')
iteration3.1hr <- subset(iteration3,iteration3$hour == '1')

iteration1.4hr <- subset(iteration1,iteration1$hour == '4')
iteration2.4hr <- subset(iteration2,iteration2$hour == '4')
iteration3.4hr <- subset(iteration3,iteration3$hour == '4')

iteration1.12hr <- subset(iteration1,iteration1$hour == '12')
iteration2.12hr <- subset(iteration2,iteration2$hour == '12')
iteration3.12hr <- subset(iteration3,iteration3$hour == '12')

iteration1.24hr <- subset(iteration1,iteration1$hour == '24')
iteration2.24hr <- subset(iteration2,iteration2$hour == '24')
iteration3.24hr <- subset(iteration3,iteration3$hour == '24')

iteration1.72hr <- subset(iteration1,iteration1$hour == '72')
iteration2.72hr <- subset(iteration2,iteration2$hour == '72')
iteration3.72hr <- subset(iteration3,iteration3$hour == '72')

# separate 1 hr into pH to extract means

iteration1.1hr.ph7 <- subset(iteration1.1hr,iteration1.1hr$ph == '7')
iteration1.1hr.ph7b <- subset(iteration1.1hr,iteration1.1hr$ph == '7b')
iteration1.1hr.ph6 <- subset(iteration1.1hr,iteration1.1hr$ph == '6')
iteration1.1hr.ph5 <- subset(iteration1.1hr,iteration1.1hr$ph == '5')
iteration1.1hr.ph3 <- subset(iteration1.1hr,iteration1.1hr$ph == '3')

iteration2.1hr.ph7 <- subset(iteration2.1hr,iteration2.1hr$ph == '7')
iteration2.1hr.ph7b <- subset(iteration2.1hr,iteration2.1hr$ph == '7b')
iteration2.1hr.ph6 <- subset(iteration2.1hr,iteration2.1hr$ph == '6')
iteration2.1hr.ph5 <- subset(iteration2.1hr,iteration2.1hr$ph == '5')
iteration2.1hr.ph3 <- subset(iteration2.1hr,iteration2.1hr$ph == '3')

iteration3.1hr.ph7 <- subset(iteration3.1hr,iteration3.1hr$ph == '7')
iteration3.1hr.ph7b <- subset(iteration3.1hr,iteration3.1hr$ph == '7b')
iteration3.1hr.ph6 <- subset(iteration3.1hr,iteration3.1hr$ph == '6')
iteration3.1hr.ph5 <- subset(iteration3.1hr,iteration3.1hr$ph == '5')
iteration3.1hr.ph3 <- subset(iteration3.1hr,iteration3.1hr$ph == '3')

iteration1.1hr.ph7.mean <- mean(iteration1.1hr.ph7$dapi)
iteration1.1hr.ph7b.mean <- mean(iteration1.1hr.ph7b$dapi)
iteration1.1hr.ph6.mean <- mean(iteration1.1hr.ph6$dapi)
iteration1.1hr.ph5.mean <- mean(iteration1.1hr.ph5$dapi)
iteration1.1hr.ph3.mean <- mean(iteration1.1hr.ph3$dapi)

iteration2.1hr.ph7.mean <- mean(iteration2.1hr.ph7$dapi)
iteration2.1hr.ph7b.mean <- mean(iteration2.1hr.ph7b$dapi)
iteration2.1hr.ph6.mean <- mean(iteration2.1hr.ph6$dapi)
iteration2.1hr.ph5.mean <- mean(iteration2.1hr.ph5$dapi)
iteration2.1hr.ph3.mean <- mean(iteration2.1hr.ph3$dapi)

iteration3.1hr.ph7.mean <- mean(iteration3.1hr.ph7$dapi)
iteration3.1hr.ph7b.mean <- mean(iteration3.1hr.ph7b$dapi)
iteration3.1hr.ph6.mean <- mean(iteration3.1hr.ph6$dapi)
iteration3.1hr.ph5.mean <- mean(iteration3.1hr.ph5$dapi)
iteration3.1hr.ph3.mean <- mean(iteration3.1hr.ph3$dapi)

# separate 4 hour into pH to extract means

iteration1.4hr.ph7 <- subset(iteration1.4hr,iteration1.4hr$ph == '7')
iteration1.4hr.ph7b <- subset(iteration1.4hr,iteration1.4hr$ph == '7b')
iteration1.4hr.ph6 <- subset(iteration1.4hr,iteration1.4hr$ph == '6')
iteration1.4hr.ph5 <- subset(iteration1.4hr,iteration1.4hr$ph == '5')
iteration1.4hr.ph3 <- subset(iteration1.4hr,iteration1.4hr$ph == '3')

iteration2.4hr.ph7 <- subset(iteration2.4hr,iteration2.4hr$ph == '7')
iteration2.4hr.ph7b <- subset(iteration2.4hr,iteration2.4hr$ph == '7b')
iteration2.4hr.ph6 <- subset(iteration2.4hr,iteration2.4hr$ph == '6')
iteration2.4hr.ph5 <- subset(iteration2.4hr,iteration2.4hr$ph == '5')
iteration2.4hr.ph3 <- subset(iteration2.4hr,iteration2.4hr$ph == '3')

iteration3.4hr.ph7 <- subset(iteration3.4hr,iteration3.4hr$ph == '7')
iteration3.4hr.ph7b <- subset(iteration3.4hr,iteration3.4hr$ph == '7b')
iteration3.4hr.ph6 <- subset(iteration3.4hr,iteration3.4hr$ph == '6')
iteration3.4hr.ph5 <- subset(iteration3.4hr,iteration3.4hr$ph == '5')
iteration3.4hr.ph3 <- subset(iteration3.4hr,iteration3.4hr$ph == '3')

iteration1.4hr.ph7.mean <- mean(iteration1.4hr.ph7$dapi)
iteration1.4hr.ph7b.mean <- mean(iteration1.4hr.ph7b$dapi)
iteration1.4hr.ph6.mean <- mean(iteration1.4hr.ph6$dapi)
iteration1.4hr.ph5.mean <- mean(iteration1.4hr.ph5$dapi)
iteration1.4hr.ph3.mean <- mean(iteration1.4hr.ph3$dapi)

iteration2.4hr.ph7.mean <- mean(iteration2.4hr.ph7$dapi)
iteration2.4hr.ph7b.mean <- mean(iteration2.4hr.ph7b$dapi)
iteration2.4hr.ph6.mean <- mean(iteration2.4hr.ph6$dapi)
iteration2.4hr.ph5.mean <- mean(iteration2.4hr.ph5$dapi)
iteration2.4hr.ph3.mean <- mean(iteration2.4hr.ph3$dapi)

iteration3.4hr.ph7.mean <- mean(iteration3.4hr.ph7$dapi)
iteration3.4hr.ph7b.mean <- mean(iteration3.4hr.ph7b$dapi)
iteration3.4hr.ph6.mean <- mean(iteration3.4hr.ph6$dapi)
iteration3.4hr.ph5.mean <- mean(iteration3.4hr.ph5$dapi)
iteration3.4hr.ph3.mean <- mean(iteration3.4hr.ph3$dapi)

# separate 12 hour into pH to extract means

iteration1.12hr.ph7 <- subset(iteration1.12hr,iteration1.12hr$ph == '7')
iteration1.12hr.ph7b <- subset(iteration1.12hr,iteration1.12hr$ph == '7b')
iteration1.12hr.ph6 <- subset(iteration1.12hr,iteration1.12hr$ph == '6')
iteration1.12hr.ph5 <- subset(iteration1.12hr,iteration1.12hr$ph == '5')
iteration1.12hr.ph3 <- subset(iteration1.12hr,iteration1.12hr$ph == '3')

iteration2.12hr.ph7 <- subset(iteration2.12hr,iteration2.12hr$ph == '7')
iteration2.12hr.ph7b <- subset(iteration2.12hr,iteration2.12hr$ph == '7b')
iteration2.12hr.ph6 <- subset(iteration2.12hr,iteration2.12hr$ph == '6')
iteration2.12hr.ph5 <- subset(iteration2.12hr,iteration2.12hr$ph == '5')
iteration2.12hr.ph3 <- subset(iteration2.12hr,iteration2.12hr$ph == '3')

iteration3.12hr.ph7 <- subset(iteration3.12hr,iteration3.12hr$ph == '7')
iteration3.12hr.ph7b <- subset(iteration3.12hr,iteration3.12hr$ph == '7b')
iteration3.12hr.ph6 <- subset(iteration3.12hr,iteration3.12hr$ph == '6')
iteration3.12hr.ph5 <- subset(iteration3.12hr,iteration3.12hr$ph == '5')
iteration3.12hr.ph3 <- subset(iteration3.12hr,iteration3.12hr$ph == '3')

iteration1.12hr.ph7.mean <- mean(iteration1.12hr.ph7$dapi)
iteration1.12hr.ph7b.mean <- mean(iteration1.12hr.ph7b$dapi)
iteration1.12hr.ph6.mean <- mean(iteration1.12hr.ph6$dapi)
iteration1.12hr.ph5.mean <- mean(iteration1.12hr.ph5$dapi)
iteration1.12hr.ph3.mean <- mean(iteration1.12hr.ph3$dapi)

iteration2.12hr.ph7.mean <- mean(iteration2.12hr.ph7$dapi)
iteration2.12hr.ph7b.mean <- mean(iteration2.12hr.ph7b$dapi)
iteration2.12hr.ph6.mean <- mean(iteration2.12hr.ph6$dapi)
iteration2.12hr.ph5.mean <- mean(iteration2.12hr.ph5$dapi)
iteration2.12hr.ph3.mean <- mean(iteration2.12hr.ph3$dapi)

iteration3.12hr.ph7.mean <- mean(iteration3.12hr.ph7$dapi)
iteration3.12hr.ph7b.mean <- mean(iteration3.12hr.ph7b$dapi)
iteration3.12hr.ph6.mean <- mean(iteration3.12hr.ph6$dapi)
iteration3.12hr.ph5.mean <- mean(iteration3.12hr.ph5$dapi)
iteration3.12hr.ph3.mean <- mean(iteration3.12hr.ph3$dapi)



# separate 24 hour into  pH to extract means

iteration1.24hr.ph7 <- subset(iteration1.24hr,iteration1.24hr$ph == '7')
iteration1.24hr.ph7b <- subset(iteration1.24hr,iteration1.24hr$ph == '7b')
iteration1.24hr.ph6 <- subset(iteration1.24hr,iteration1.24hr$ph == '6')
iteration1.24hr.ph5 <- subset(iteration1.24hr,iteration1.24hr$ph == '5')
iteration1.24hr.ph3 <- subset(iteration1.24hr,iteration1.24hr$ph == '3')

iteration2.24hr.ph7 <- subset(iteration2.24hr,iteration2.24hr$ph == '7')
iteration2.24hr.ph7b <- subset(iteration2.24hr,iteration2.24hr$ph == '7b')
iteration2.24hr.ph6 <- subset(iteration2.24hr,iteration2.24hr$ph == '6')
iteration2.24hr.ph5 <- subset(iteration2.24hr,iteration2.24hr$ph == '5')
iteration2.24hr.ph3 <- subset(iteration2.24hr,iteration2.24hr$ph == '3')

iteration3.24hr.ph7 <- subset(iteration3.24hr,iteration3.24hr$ph == '7')
iteration3.24hr.ph7b <- subset(iteration3.24hr,iteration3.24hr$ph == '7b')
iteration3.24hr.ph6 <- subset(iteration3.24hr,iteration3.24hr$ph == '6')
iteration3.24hr.ph5 <- subset(iteration3.24hr,iteration3.24hr$ph == '5')
iteration3.24hr.ph3 <- subset(iteration3.24hr,iteration3.24hr$ph == '3')

iteration1.24hr.ph7.mean <- mean(iteration1.24hr.ph7$dapi)
iteration1.24hr.ph7b.mean <- mean(iteration1.24hr.ph7b$dapi)
iteration1.24hr.ph6.mean <- mean(iteration1.24hr.ph6$dapi)
iteration1.24hr.ph5.mean <- mean(iteration1.24hr.ph5$dapi)
iteration1.24hr.ph3.mean <- mean(iteration1.24hr.ph3$dapi)

iteration2.24hr.ph7.mean <- mean(iteration2.24hr.ph7$dapi)
iteration2.24hr.ph7b.mean <- mean(iteration2.24hr.ph7b$dapi)
iteration2.24hr.ph6.mean <- mean(iteration2.24hr.ph6$dapi)
iteration2.24hr.ph5.mean <- mean(iteration2.24hr.ph5$dapi)
iteration2.24hr.ph3.mean <- mean(iteration2.24hr.ph3$dapi)

iteration3.24hr.ph7.mean <- mean(iteration3.24hr.ph7$dapi)
iteration3.24hr.ph7b.mean <- mean(iteration3.24hr.ph7b$dapi)
iteration3.24hr.ph6.mean <- mean(iteration3.24hr.ph6$dapi)
iteration3.24hr.ph5.mean <- mean(iteration3.24hr.ph5$dapi)
iteration3.24hr.ph3.mean <- mean(iteration3.24hr.ph3$dapi)

# separate 72 hour into pH to extract means
iteration1.72hr
iteration1.72hr.ph7 <- subset(iteration1.72hr,iteration1.72hr$ph == '7')
iteration1.72hr.ph7b <- subset(iteration1.72hr,iteration1.72hr$iteration == 'b0')
iteration1.72hr.ph6 <- subset(iteration1.72hr,iteration1.72hr$ph == '6')
iteration1.72hr.ph5 <- subset(iteration1.72hr,iteration1.72hr$ph == '5')
iteration1.72hr.ph3 <- subset(iteration1.72hr,iteration1.72hr$ph == '3')

iteration2.72hr.ph7 <- subset(iteration2.72hr,iteration2.72hr$ph == '7')
iteration2.72hr.ph7b <- subset(iteration2.72hr,iteration2.72hr$ph == '7b')
iteration2.72hr.ph6 <- subset(iteration2.72hr,iteration2.72hr$ph == '6')
iteration2.72hr.ph5 <- subset(iteration2.72hr,iteration2.72hr$ph == '5')
iteration2.72hr.ph3 <- subset(iteration2.72hr,iteration2.72hr$ph == '3')

iteration3.72hr.ph7 <- subset(iteration3.72hr,iteration3.72hr$ph == '7')
iteration3.72hr.ph7b <- subset(iteration3.72hr,iteration3.72hr$ph == '7b')
iteration3.72hr.ph6 <- subset(iteration3.72hr,iteration3.72hr$ph == '6')
iteration3.72hr.ph5 <- subset(iteration3.72hr,iteration3.72hr$ph == '5')
iteration3.72hr.ph3 <- subset(iteration3.72hr,iteration3.72hr$ph == '3')


iteration1.72hr.ph7.mean <- mean(iteration1.72hr.ph7$dapi)
iteration1.72hr.ph7b.mean <- mean(iteration1.72hr.ph7b$dapi)
iteration1.72hr.ph6.mean <- mean(iteration1.72hr.ph6$dapi)
iteration1.72hr.ph5.mean <- mean(iteration1.72hr.ph5$dapi)
iteration1.72hr.ph3.mean <- mean(iteration1.72hr.ph3$dapi)

iteration2.72hr.ph7.mean <- mean(iteration2.72hr.ph7$dapi)
iteration2.72hr.ph7b.mean <- mean(iteration2.72hr.ph7b$dapi)
iteration2.72hr.ph6.mean <- mean(iteration2.72hr.ph6$dapi)
iteration2.72hr.ph5.mean <- mean(iteration2.72hr.ph5$dapi)
iteration2.72hr.ph3.mean <- mean(iteration2.72hr.ph3$dapi)

iteration3.72hr.ph7.mean <- mean(iteration3.72hr.ph7$dapi)
iteration3.72hr.ph7b.mean <- mean(iteration3.72hr.ph7b$dapi)
iteration3.72hr.ph6.mean <- mean(iteration3.72hr.ph6$dapi)
iteration3.72hr.ph5.mean <- mean(iteration3.72hr.ph5$dapi)
iteration3.72hr.ph3.mean <- mean(iteration3.72hr.ph3$dapi)

# combine all of our means into unified table (n=3)
# wish there was better way to do this

hours <- c(rep('1', times = 15),
           rep('4', times = 15),
           rep('12', times = 15),
           rep('24', times = 15),
           rep('72', times = 15))


# this nightmare repeats 1x5, 2x5, 3x5 five times over
iters <- c(rep(c(rep('1', times = 5),
                 rep('2', times = 5),
                 rep('3', times = 5)),
               times = 5))

phs <- as.factor(c(rep(c('7.3-7.4','6.8-7.3','6.5-6.8','5.5-5.8','3.5-4.0'),times = 15)))

means <- c(iteration1.1hr.ph7.mean,iteration1.1hr.ph7b.mean,iteration1.1hr.ph6.mean,iteration1.1hr.ph5.mean,iteration1.1hr.ph3.mean,
           iteration2.1hr.ph7.mean,iteration2.1hr.ph7b.mean,iteration2.1hr.ph6.mean,iteration2.1hr.ph5.mean,iteration2.1hr.ph3.mean,
           iteration3.1hr.ph7.mean,iteration3.1hr.ph7b.mean,iteration3.1hr.ph6.mean,iteration3.1hr.ph5.mean,iteration3.1hr.ph3.mean,
           iteration1.4hr.ph7.mean,iteration1.4hr.ph7b.mean,iteration1.4hr.ph6.mean,iteration1.4hr.ph5.mean,iteration1.4hr.ph3.mean,
           iteration2.4hr.ph7.mean,iteration2.4hr.ph7b.mean,iteration2.4hr.ph6.mean,iteration2.4hr.ph5.mean,iteration2.4hr.ph3.mean,
           iteration3.4hr.ph7.mean,iteration3.4hr.ph7b.mean,iteration3.4hr.ph6.mean,iteration3.4hr.ph5.mean,iteration3.4hr.ph3.mean,
           iteration1.12hr.ph7.mean,iteration1.12hr.ph7b.mean,iteration1.12hr.ph6.mean,iteration1.12hr.ph5.mean,iteration1.12hr.ph3.mean,
           iteration2.12hr.ph7.mean,iteration2.12hr.ph7b.mean,iteration2.12hr.ph6.mean,iteration2.12hr.ph5.mean,iteration2.12hr.ph3.mean,
           iteration3.12hr.ph7.mean,iteration3.12hr.ph7b.mean,iteration3.12hr.ph6.mean,iteration3.12hr.ph5.mean,iteration3.12hr.ph3.mean,
           iteration1.24hr.ph7.mean,iteration1.24hr.ph7b.mean,iteration1.24hr.ph6.mean,iteration1.24hr.ph5.mean,iteration1.24hr.ph3.mean,
           iteration2.24hr.ph7.mean,iteration2.24hr.ph7b.mean,iteration2.24hr.ph6.mean,iteration2.24hr.ph5.mean,iteration2.24hr.ph3.mean,
           iteration3.24hr.ph7.mean,iteration3.24hr.ph7b.mean,iteration3.24hr.ph6.mean,iteration3.24hr.ph5.mean,iteration3.24hr.ph3.mean,
           iteration1.72hr.ph7.mean,iteration1.72hr.ph7b.mean,iteration1.72hr.ph6.mean,iteration1.72hr.ph5.mean,iteration1.72hr.ph3.mean,
           iteration2.72hr.ph7.mean,iteration2.72hr.ph7b.mean,iteration2.72hr.ph6.mean,iteration2.72hr.ph5.mean,iteration2.72hr.ph3.mean,
           iteration3.72hr.ph7.mean,iteration3.72hr.ph7b.mean,iteration3.72hr.ph6.mean,iteration3.72hr.ph5.mean,iteration3.72hr.ph3.mean)

extracted.viability.data <- data.frame(
    Hour = hours,
    Iterations = iters,
    pH = as.factor(phs),
    averages = means)
extracted.viability.data

# LETS DO HYPOTHESIS TESTING!
# first, lets check for normal distribution using shapiro test (normal: p > 0.05)
# But we will need to subset our averaged technical replicates

extracted.1hr <- subset(extracted.viability.data,extracted.viability.data$Hour == '1')
extracted.4hr <- subset(extracted.viability.data,extracted.viability.data$Hour == '4')
extracted.12hr <- subset(extracted.viability.data,extracted.viability.data$Hour == '12')
extracted.24hr <- subset(extracted.viability.data,extracted.viability.data$Hour == '24')
extracted.72hr <- subset(extracted.viability.data,extracted.viability.data$Hour == '72')

shapiro.test(subset(extracted.1hr,extracted.1hr$pH == '7.3-7.4')$averages) #norm
shapiro.test(subset(extracted.1hr,extracted.1hr$pH == '6.8-7.3')$averages) #norm
shapiro.test(subset(extracted.1hr,extracted.1hr$pH == '6.5-6.8')$averages) #norm
shapiro.test(subset(extracted.1hr,extracted.1hr$pH == '5.5-5.8')$averages) #norm
shapiro.test(subset(extracted.1hr,extracted.1hr$pH == '3.5-4.0')$averages) #norm

shapiro.test(subset(extracted.4hr,extracted.4hr$pH == '7.3-7.4')$averages) #norm
shapiro.test(subset(extracted.4hr,extracted.4hr$pH == '6.8-7.3')$averages) #norm
shapiro.test(subset(extracted.4hr,extracted.4hr$pH == '6.5-6.8')$averages) #norm
shapiro.test(subset(extracted.4hr,extracted.4hr$pH == '5.5-5.8')$averages) #norm
shapiro.test(subset(extracted.4hr,extracted.4hr$pH == '3.5-4.0')$averages) #norm

shapiro.test(subset(extracted.24hr,extracted.24hr$pH == '7.3-7.4')$averages) #norm
shapiro.test(subset(extracted.24hr,extracted.24hr$pH == '6.8-7.3')$averages) #norm
shapiro.test(subset(extracted.24hr,extracted.24hr$pH == '6.5-6.8')$averages) #norm
shapiro.test(subset(extracted.24hr,extracted.24hr$pH == '5.5-5.8')$averages) #norm
shapiro.test(subset(extracted.24hr,extracted.24hr$pH == '3.5-4.0')$averages) # NOT ? norm

shapiro.test(subset(extracted.12hr,extracted.12hr$pH == '7.3-7.4')$averages) #norm
shapiro.test(subset(extracted.12hr,extracted.12hr$pH == '6.8-7.3')$averages) #norm
shapiro.test(subset(extracted.12hr,extracted.12hr$pH == '6.5-6.8')$averages) #norm
shapiro.test(subset(extracted.12hr,extracted.12hr$pH == '5.5-5.8')$averages) #norm
shapiro.test(subset(extracted.12hr,extracted.12hr$pH == '3.5-4.0')$averages) # NOT norm

shapiro.test(subset(extracted.72hr,extracted.72hr$pH == '7.3-7.4')$averages) #norm
shapiro.test(subset(extracted.72hr,extracted.72hr$pH == '6.8-7.3')$averages) #norm
shapiro.test(subset(extracted.72hr,extracted.72hr$pH == '6.5-6.8')$averages) #norm
shapiro.test(subset(extracted.72hr,extracted.72hr$pH == '5.5-5.8')$averages) #norm
shapiro.test(subset(extracted.72hr,extracted.72hr$pH == '3.5-4.0')$averages) # NOT norm

# our 3.5-4.0 groups are not normal, but all else? 
# maybe do dunnett's test?

dunn.test(g=extracted.1hr$pH,x=extracted.1hr$averages)
dunn.test(g=extracted.4hr$pH,x=extracted.4hr$averages)
dunn.test(g=extracted.12hr$pH,x=extracted.12hr$averages)
dunn.test(g=extracted.24hr$pH,x=extracted.24hr$averages)
dunn.test(g=extracted.72hr$pH,x=extracted.72hr$averages)

# We will need to repose our data for a better bar plot
# we will need to extract mean, then standard deviations

extracted.1hr.ph7.mean <- mean(subset(extracted.1hr,extracted.1hr$pH == '7.3-7.4')$averages)
extracted.1hr.ph7b.mean <- mean(subset(extracted.1hr,extracted.1hr$pH == '6.8-7.3')$averages)
extracted.1hr.ph6.mean <- mean(subset(extracted.1hr,extracted.1hr$pH == '6.5-6.8')$averages)
extracted.1hr.ph5.mean <- mean(subset(extracted.1hr,extracted.1hr$pH == '5.5-5.8')$averages)
extracted.1hr.ph3.mean <- mean(subset(extracted.1hr,extracted.1hr$pH == '3.5-4.0')$averages)

extracted.1hr.ph7.stdev <- sd(subset(extracted.1hr,extracted.1hr$pH == '7.3-7.4')$averages)
extracted.1hr.ph7b.stdev <- sd(subset(extracted.1hr,extracted.1hr$pH == '6.8-7.3')$averages)
extracted.1hr.ph6.stdev <- sd(subset(extracted.1hr,extracted.1hr$pH == '6.5-6.8')$averages)
extracted.1hr.ph5.stdev <- sd(subset(extracted.1hr,extracted.1hr$pH == '5.5-5.8')$averages)
extracted.1hr.ph3.stdev <- sd(subset(extracted.1hr,extracted.1hr$pH == '3.5-4.0')$averages)

extracted.4hr.ph7.mean <- mean(subset(extracted.4hr,extracted.4hr$pH == '7.3-7.4')$averages)
extracted.4hr.ph7b.mean <- mean(subset(extracted.4hr,extracted.4hr$pH == '6.8-7.3')$averages)
extracted.4hr.ph6.mean <- mean(subset(extracted.4hr,extracted.4hr$pH == '6.5-6.8')$averages)
extracted.4hr.ph5.mean <- mean(subset(extracted.4hr,extracted.4hr$pH == '5.5-5.8')$averages)
extracted.4hr.ph3.mean <- mean(subset(extracted.4hr,extracted.4hr$pH == '3.5-4.0')$averages)

extracted.4hr.ph7.stdev <- sd(subset(extracted.4hr,extracted.4hr$pH == '7.3-7.4')$averages)
extracted.4hr.ph7b.stdev <- sd(subset(extracted.4hr,extracted.4hr$pH == '6.8-7.3')$averages)
extracted.4hr.ph6.stdev <- sd(subset(extracted.4hr,extracted.4hr$pH == '6.5-6.8')$averages)
extracted.4hr.ph5.stdev <- sd(subset(extracted.4hr,extracted.4hr$pH == '5.5-5.8')$averages)
extracted.4hr.ph3.stdev <- sd(subset(extracted.4hr,extracted.4hr$pH == '3.5-4.0')$averages)

extracted.12hr.ph7.mean <- mean(subset(extracted.12hr,extracted.12hr$pH == '7.3-7.4')$averages)
extracted.12hr.ph7b.mean <- mean(subset(extracted.12hr,extracted.12hr$pH == '6.8-7.3')$averages)
extracted.12hr.ph6.mean <- mean(subset(extracted.12hr,extracted.12hr$pH == '6.5-6.8')$averages)
extracted.12hr.ph5.mean <- mean(subset(extracted.12hr,extracted.12hr$pH == '5.5-5.8')$averages)
extracted.12hr.ph3.mean <- mean(subset(extracted.12hr,extracted.12hr$pH == '3.5-4.0')$averages)

extracted.12hr.ph7.stdev <- sd(subset(extracted.12hr,extracted.12hr$pH == '7.3-7.4')$averages)
extracted.12hr.ph7b.stdev <- sd(subset(extracted.12hr,extracted.12hr$pH == '6.8-7.3')$averages)
extracted.12hr.ph6.stdev <- sd(subset(extracted.12hr,extracted.12hr$pH == '6.5-6.8')$averages)
extracted.12hr.ph5.stdev <- sd(subset(extracted.12hr,extracted.12hr$pH == '5.5-5.8')$averages)
extracted.12hr.ph3.stdev <- sd(subset(extracted.12hr,extracted.12hr$pH == '3.5-4.0')$averages)

extracted.24hr.ph7.mean <- mean(subset(extracted.24hr,extracted.24hr$pH == '7.3-7.4')$averages)
extracted.24hr.ph7b.mean <- mean(subset(extracted.24hr,extracted.24hr$pH == '6.8-7.3')$averages)
extracted.24hr.ph6.mean <- mean(subset(extracted.24hr,extracted.24hr$pH == '6.5-6.8')$averages)
extracted.24hr.ph5.mean <- mean(subset(extracted.24hr,extracted.24hr$pH == '5.5-5.8')$averages)
extracted.24hr.ph3.mean <- mean(subset(extracted.24hr,extracted.24hr$pH == '3.5-4.0')$averages)

extracted.24hr.ph7.stdev <- sd(subset(extracted.24hr,extracted.24hr$pH == '7.3-7.4')$averages)
extracted.24hr.ph7b.stdev <- sd(subset(extracted.24hr,extracted.24hr$pH == '6.8-7.3')$averages)
extracted.24hr.ph6.stdev <- sd(subset(extracted.24hr,extracted.24hr$pH == '6.5-6.8')$averages)
extracted.24hr.ph5.stdev <- sd(subset(extracted.24hr,extracted.24hr$pH == '5.5-5.8')$averages)
extracted.24hr.ph3.stdev <- sd(subset(extracted.24hr,extracted.24hr$pH == '3.5-4.0')$averages)

extracted.72hr.ph7.mean <- mean(subset(extracted.72hr,extracted.72hr$pH == '7.3-7.4')$averages)
extracted.72hr.ph7b.mean <- mean(subset(extracted.72hr,extracted.72hr$pH == '6.8-7.3')$averages)
extracted.72hr.ph6.mean <- mean(subset(extracted.72hr,extracted.72hr$pH == '6.5-6.8')$averages)
extracted.72hr.ph5.mean <- mean(subset(extracted.72hr,extracted.72hr$pH == '5.5-5.8')$averages)
extracted.72hr.ph3.mean <- mean(subset(extracted.72hr,extracted.72hr$pH == '3.5-4.0')$averages)

extracted.72hr.ph7.stdev <- sd(subset(extracted.72hr,extracted.72hr$pH == '7.3-7.4')$averages)
extracted.72hr.ph7b.stdev <- sd(subset(extracted.72hr,extracted.72hr$pH == '6.8-7.3')$averages)
extracted.72hr.ph6.stdev <- sd(subset(extracted.72hr,extracted.72hr$pH == '6.5-6.8')$averages)
extracted.72hr.ph5.stdev <- sd(subset(extracted.72hr,extracted.72hr$pH == '5.5-5.8')$averages)
extracted.72hr.ph3.stdev <- sd(subset(extracted.72hr,extracted.72hr$pH == '3.5-4.0')$averages)

# Now we need to re-consolidate all this into a frame for plotting

hours.consolidated <- c(rep('1',times = 5),
                        rep('4', times = 5),
                        rep('12', times = 5),
                        rep('24',times = 5),
                        rep('72',times = 5))

ph.consolidated <- c(rep(c('7.3-7.4','6.8-7.3','6.5-6.8','5.5-5.8','3.5-4.0'),times = 5))


means.consolidated <- c(extracted.1hr.ph7.mean,extracted.1hr.ph7b.mean,extracted.1hr.ph6.mean,extracted.1hr.ph5.mean,extracted.1hr.ph3.mean,
                        extracted.1hr.ph7.mean,extracted.4hr.ph7b.mean,extracted.4hr.ph6.mean,extracted.4hr.ph5.mean,extracted.4hr.ph3.mean,
                        extracted.1hr.ph7.mean,extracted.12hr.ph7b.mean,extracted.12hr.ph6.mean,extracted.12hr.ph5.mean,extracted.12hr.ph3.mean,
                        extracted.1hr.ph7.mean,extracted.24hr.ph7b.mean,extracted.24hr.ph6.mean,extracted.24hr.ph5.mean,extracted.24hr.ph3.mean,
                        extracted.1hr.ph7.mean,extracted.72hr.ph7b.mean,extracted.72hr.ph6.mean,extracted.72hr.ph5.mean,extracted.72hr.ph3.mean)

stdev.consolidated <- c(extracted.1hr.ph7.stdev,extracted.1hr.ph7b.stdev,extracted.1hr.ph6.stdev,extracted.1hr.ph5.stdev,extracted.1hr.ph3.stdev,
                        extracted.4hr.ph7.stdev,extracted.4hr.ph7b.stdev,extracted.4hr.ph6.stdev,extracted.4hr.ph5.stdev,extracted.4hr.ph3.stdev,
                        extracted.12hr.ph7.stdev,extracted.12hr.ph7b.stdev,extracted.12hr.ph6.stdev,extracted.12hr.ph5.stdev,extracted.12hr.ph3.stdev,
                        extracted.24hr.ph7.stdev,extracted.24hr.ph7b.stdev,extracted.24hr.ph6.stdev,extracted.24hr.ph5.stdev,extracted.24hr.ph3.stdev,
                        extracted.72hr.ph7.stdev,extracted.72hr.ph7b.stdev,extracted.72hr.ph6.stdev,extracted.72hr.ph5.stdev,extracted.72hr.ph3.stdev)

# consolidate all of this into a new data frame
consolidated.plot.data <- data.frame(
    hour = hours.consolidated,
    pH = ph.consolidated,
    avg = means.consolidated,
    stdev = stdev.consolidated)

# NOW ITS TIME TO PLOT !!
ggplot() + 
    geom_col(data = consolidated.plot.data, aes(x = pH, y=avg, fill = pH),
             stat='identity',width=0.9,col='black',
             position = position_dodge(width=0.1)) +
    geom_errorbar(data = consolidated.plot.data,
                  aes(x=pH,ymin=avg-stdev,ymax=avg+stdev),width=0.34) +
    facet_wrap(as.factor(consolidated.plot.data$hour)) + 
    scale_fill_manual(values = c('#ffffcc','#78c679','#bcbddc','#6baed6','#969696')) + 
    theme_woodn()
