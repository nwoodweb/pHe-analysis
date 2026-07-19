# WOOD-NT contact@nwoodweb.xyz 2026
# MIT LICENSE
# Compute cytosolic pH of experimental groups using a Nigericin standard
# curve. Fluorescent agent is BCECF-AM (AAT Bioquest)

library(ggplot2)
library(ggpubr)

# generate the standard curve and its corresponding linear regression
phcalibrationcurve <- read.csv('/home/woodn/Academic/phcurve.csv')

model.phcalibrationcurve <- lm(phcalibrationcurve$Intensity ~ phcalibrationcurve$pH)

yintercept.phcalibrationcurve <- coef(model.phcalibrationcurve)[1]
slope.phcalibrationcurve <- coef(model.phcalibrationcurve)[2]
rsqr.phcalibrationcurve <- summary(model.phcalibrationcurve)$r.squared

# Unfortunately the way to add more than 2 sigfigs to a r^2 or slope-intercept
# in ggpubr is a bit nonintuitive. Use the above output and edit it in
# either in R (which is below) or in inkscape

ggplot(data = phcalibrationcurve, aes(y = Intensity, x = pH )) + 
    stat_summary(fun = "mean",
                 geom = "point",
                 size = 6) + 
    
    stat_summary(fun.data = "mean_sdl", fun.args = list(mult = 1),
                 geom = "errorbar",
                 width = 0.07) + 
    
    geom_smooth(method = "lm", se = F, linewidth = 1.5) + 
    
    # linear regression function
    annotate("text",
             x = 6.0, y = 700, 
             label = paste("f(x) = ",signif(slope.phcalibrationcurve, digits = 6),
                           "x - ",abs(signif(yintercept.phcalibrationcurve, digits = 6))),
             size = 6) + 
    
    # linear regression coefficient
    annotate("text",
             x = 6.0, y = 650,
             label = paste("italic(R)^2 ==", signif(rsqr.phcalibrationcurve, digits = 6)),
             parse = T, 
             size = 6) + 
    
    scale_y_continuous(name = "Intensity (Arb.)",
                       limits = c(0,800),
                       breaks = seq(0,800,100)) + 
    scale_x_continuous(name = "pH",
                       limits = c(5.4,8.1),
                       breaks = c(5.5,6.0,6.5,7.0,7.5,8.0)) + 
    theme_woodn()

# Now its time to process experimental data


# this function will convert pixel intensity to pH based on standard
# curve regression parameters

intensity_2_ph <- function(intensity) {
    # y = mx + b becomes  x = (y - b) / m
    ph <- (intensity - yintercept.phcalibrationcurve) / slope.phcalibrationcurve
    return(ph)
}

