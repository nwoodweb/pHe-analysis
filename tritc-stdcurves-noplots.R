# WOOD-NT 17JULY2026 contact@nwoodweb.xyz
# MIT LICENSE
# This script takes an organized csv of tritc-dextran standard curve points
# and approximates its linear regression.
#
# RETURNS: CSV of regression coefficients and R^2 for each pH and time point
# CSV can be used for supplemental tables. Plotting is probably unnecessary. 

require(tidyverse)

data.stdcurves <- read.csv('/home/woodn/Desktop/tritc-stdcurve.csv')

data.stdcurves.4hr <- subset(data.stdcurves, data.stdcurves$time == 4)

ph7.4hr <- subset(data.stdcurves.4hr, data.stdcurves.4hr$ph == '7.3-7.4')
ph8.4hr <- subset(data.stdcurves.4hr, data.stdcurves.4hr$ph == '6.9-7.2')
ph6.4hr <- subset(data.stdcurves.4hr, data.stdcurves.4hr$ph == '6.5-6.8')
ph5.4hr <- subset(data.stdcurves.4hr, data.stdcurves.4hr$ph == '5.5-5.8')

model.ph7.4hr <- lm(rfu ~ concentration, data = ph7.4hr)
ph7.4hr.coef <- coef(model.ph7.4hr)
ph7.4hr.rsquared <-summary(model.ph7.4hr)$r.squared

model.ph8.4hr <- lm(rfu ~ concentration, data = ph8.4hr)
ph8.4hr.coef <- coef(model.ph8.4hr)
ph8.4hr.rsquared <-summary(model.ph8.4hr)$r.squared

model.ph6.4hr <- lm(rfu ~ concentration, data = ph6.4hr)
ph6.4hr.coef <- coef(model.ph6.4hr)
ph6.4hr.rsquared <- summary(model.ph6.4hr)$r.squared

model.ph5.4hr <- lm(rfu ~ concentration, data = ph5.4hr)
ph5.4hr.coef <- coef(model.ph5.4hr)
ph5.4hr.rsquared <- summary(model.ph5.4hr)$r.squared

data.stdcurves.24hr <- subset(data.stdcurves, data.stdcurves$time == 24)

ph7.24hr <- subset(data.stdcurves.24hr, data.stdcurves.24hr$ph == '7.3-7.4')
ph8.24hr <- subset(data.stdcurves.24hr, data.stdcurves.24hr$ph == '6.9-7.2')
ph6.24hr <- subset(data.stdcurves.24hr, data.stdcurves.24hr$ph == '6.5-6.8')
ph5.24hr <- subset(data.stdcurves.24hr, data.stdcurves.24hr$ph == '5.5-5.8')

model.ph7.24hr <- lm(rfu ~ concentration, data = ph7.24hr)
ph7.24hr.coef <- coef(model.ph7.24hr)
ph7.24hr.rsquared <- summary(model.ph7.24hr)$r.squared

model.ph8.24hr <- lm(rfu ~ concentration, data = ph8.24hr)
ph8.24hr.coef <- coef(model.ph8.24hr)
ph8.24hr.rsquared <- summary(model.ph8.24hr)$r.squared


model.ph6.24hr <- lm(rfu ~ concentration, data = ph6.24hr)
ph6.24hr.coef <- coef(model.ph6.24hr)
ph6.24hr.rsquared <- summary(model.ph6.24hr)$r.squared


model.ph5.24hr <- lm(rfu ~ concentration, data = ph5.24hr)
ph5.24hr.coef <- coef(model.ph5.24hr)
ph5.24hr.rsquared <- summary(model.ph5.24hr)$r.squared

regression.data.4hr <- data.frame(ph = c('7.3-7.4',
										 '6.9-7.2',
										 '6.5-6.8',
										 '5.5-5.8'),
								  slope = c(ph7.4hr.coef[2],
								  		  ph8.4hr.coef[2],
								  		  ph6.4hr.coef[2],
								  		  ph5.4hr.coef[2]),
								  intercept = c(ph7.4hr.coef[1],
								  			  ph8.4hr.coef[1],
								  			  ph6.4hr.coef[1],
								  			  ph5.4hr.coef[1]),
								  rsquared = c(ph7.4hr.rsquared,
								  			 ph8.4hr.rsquared,
								  			 ph6.4hr.rsquared,
								  			 ph5.4hr.rsquared)) 

regression.data.24hr <- data.frame(ph = c('7.3-7.4',
										 '6.9-7.2',
										 '6.5-6.8',
										 '5.5-5.8'),
								  slope = c(ph7.24hr.coef[2],
								  		  ph8.24hr.coef[2],
								  		  ph6.24hr.coef[2],
								  		  ph5.24hr.coef[2]),
								  intercept = c(ph7.24hr.coef[1],
								  			  ph8.24hr.coef[1],
								  			  ph6.24hr.coef[1],
								  			  ph5.24hr.coef[1]),
								  rsquared = c(ph7.24hr.rsquared,
								  			 ph8.24hr.rsquared,
								  			 ph6.24hr.rsquared,
								  			 ph5.24hr.rsquared)) 

regression.data.combined <- rbind(regression.data.4hr,
								  regression.data.24hr)

write.csv(regression.data.combined, file = 'tritc-dextrant-stdcurve-coeff.csv',
		  sep = ',')

