library(tidyverse)
library(dunn.test)


# data
ph7.4hr.data <- read.csv("/media/woodn/D380-0B3C/cellcell/ph7-4hr-fwhm.csv")
ph7.4hr.data$ph <- '7.3-7.4'
ph7.12hr.data <- read.csv("/media/woodn/D380-0B3C/cellcell/ph7-12hr-fwhm.csv")
ph7.12hr.data$ph <- '7.3-7.4'

ph7b.4hr.data <- read.csv("/media/woodn/D380-0B3C/cellcell/ph8-04hr-fwhm.csv")
ph7b.4hr.data$ph <- '6.9-7.2'
ph7b.12hr.data$time <- '12hr'
ph7b.4hr.data <- subset(ph7b.4hr.data, ph7b.4hr.data$time == '04hr')
ph7b.12hr.data <- read.csv("/media/woodn/D380-0B3C/cellcell/ph8-12hr-fwhm.csv")
ph7b.12hr.data$ph <- '6.9-7.2'
ph7b.12hr.data$time <- '12hr'


ph6.4hr.data <- read.csv("/media/woodn/D380-0B3C/cellcell/ph6-04hr-fwhm.csv")
ph6.4hr.data$ph <- '6.5-6.8'
ph6.4hr.data$time <- "04hr"
ph6.12hr.data <- read.csv("/media/woodn/D380-0B3C/cellcell/ph6-12hr-fwhm.csv")
ph6.12hr.data$ph <- '6.5-6.8'

sham.data <- read.csv("/media/woodn/D380-0B3C/cellcell/sham-fwhm.csv")
sham.data$time <- '00hr'
sham.data$ph <-  'Immediate'

rbind()

# look at shapiro, we need to use non-parametric test! 
shapiro.test(ph7.4hr.data$fwhm) # 0.92
shapiro.test(ph7.12hr.data$fwhm) # 0.51

shapiro.test(ph7b.4hr.data$fwhm) # 0.12
shapiro.test(ph7b.12hr.data$fwhm) # 0.005

shapiro.test(ph6.4hr.data$fwhm) # 0.003
shapiro.test(ph6.12hr.data$fwhm) # 0.001

shapiro.test(sham.data$fwhm) # 0.2861

data.consolidated <- bind_rows(ph7.4hr.data,ph7.12hr.data,
                               ph7b.4hr.data,ph7b.12hr.data,
                               ph6.4hr.data,ph6.12hr.data,
                               sham.data)

sham.data.4hr.hack <- sham.data
sham.data.4hr.hack$time <- '04hr'

data.4hr.consolidated <- bind_rows(ph7.4hr.data,
                               ph7b.4hr.data,
                               ph6.4hr.data,
                               sham.data.4hr.hack)
data.4hr.consolidated.nosham <- bind_rows(ph7.4hr.data,
                                          ph7b.4hr.data,
                                          ph6.4hr.data)

sham.data.12hr.hack <- sham.data
sham.data.12hr.hack$time <- '04hr'

data.12hr.consolidated <- bind_rows(ph7.12hr.data,
                               ph7b.12hr.data,
                               ph6.12hr.data,
                               sham.data.12hr.hack)
data.12hr.consolidated.nosham <- bind_rows(ph7.12hr.data,
                                           ph7b.12hr.data,
                                           ph6.12hr.data)

dunn.test(data.4hr.consolidated$fwhm, data.4hr.consolidated$ph)
dunn.test(data.12hr.consolidated$fwhm, data.12hr.consolidated$ph)

ggplot(data = data.4hr.consolidated) + 
    geom_boxplot(aes(x= ph, y = fwhm, fill = ph),
                 outlier.shape = NA) + 
    geom_jitter(aes(x = ph, y = fwhm,),
                width = 0.15, alpha = 0.4, cex = 4) + 
    scale_x_discrete(name = 'Hour 4', limits = rev, labels = c())+
    scale_y_continuous(name =expression(bold(FWHM) ~ (bold(mu * m))),
                       limits = c(0,2.5)) + 
    scale_fill_manual(name = "pHe", values = c('#9e9ac8','#addd8e','#dadada', '#d4aa00')) + 
    theme_woodn()

ggplot(data = data.12hr.consolidated) + 
    geom_boxplot(aes(x= ph, y = fwhm, fill = ph),
                 outlier.shape = NA) + 
    geom_jitter(aes(x = ph, y = fwhm,),
                width = 0.15, alpha = 0.4, cex = 4) + 
    scale_x_discrete(name = 'Hour 12', limits = rev, labels = c())+
    scale_y_continuous(name =expression(bold(FWHM) ~ (bold(mu * m))),
                       limits = c(0,2.5)) + 
    scale_fill_manual(name = "pHe", values = c('#9e9ac8','#addd8e','#dadada', '#d4aa00')) + 
    theme_woodn()


ggplot(data = data.4hr.consolidated.nosham) + 
    geom_boxplot(aes(x= ph, y = fwhm, fill = ph),
                 outlier.shape = NA) + 
    geom_jitter(aes(x = ph, y = fwhm,),
                width = 0.15, alpha = 0.4, cex = 4) + 
    scale_x_discrete(name = 'Hour 4', limits = rev, labels = c())+
    scale_y_continuous(name =expression(bold(FWHM) ~ (bold(mu * m))),
                       limits = c(0,2.5)) + 
    scale_fill_manual(name = "pHe", values = c('#9e9ac8','#addd8e','#dadada', '#d4aa00')) + 
    theme_woodn()

ggplot(data = data.12hr.consolidated.nosham) + 
    geom_boxplot(aes(x= ph, y = fwhm, fill = ph),
                 outlier.shape = NA) + 
    geom_jitter(aes(x = ph, y = fwhm,),
                width = 0.15, alpha = 0.4, cex = 4) + 
    scale_x_discrete(name = 'Hour 12', limits = rev, labels = c())+
    scale_y_continuous(name =expression(bold(FWHM) ~ (bold(mu * m))),
                       limits = c(0,2.5)) + 
    scale_fill_manual(name = "pHe", values = c('#9e9ac8','#addd8e','#dadada', '#d4aa00')) + 
    theme_woodn()


dunn.test(data.12hr.consolidated.nosham$amplitude, data.12hr.consolidated.nosham$ph)
ggplot(data = data.4hr.consolidated.nosham) + 
    geom_boxplot(aes(x= ph, y = amplitude, fill = ph),
                 outlier.shape = NA) + 
    geom_jitter(aes(x = ph, y = amplitude,),
                width = 0.15, alpha = 0.4, cex = 4) + 
    scale_x_discrete(name = 'Hour 4', limits = rev, labels = c())+
    scale_y_continuous(name = "Amplitude \n (Max. Pixel Intensity)" ,
                       limits = c(0,6000),
                       breaks = seq(0,6000,1000)) + 
    scale_fill_manual(name = "pHe", values = c('#9e9ac8','#addd8e','#dadada', '#d4aa00')) + 
    theme_woodn()


ggplot(data = data.12hr.consolidated.nosham) + 
    geom_boxplot(aes(x= ph, y = amplitude, fill = ph),
                 outlier.shape = NA) + 
    geom_jitter(aes(x = ph, y = amplitude,),
                width = 0.15, alpha = 0.4, cex = 4) + 
    scale_x_discrete(name = 'Hour 12', limits = rev, labels = c())+
    scale_y_continuous(name = "Amplitude \n (Max. Pixel Intensity)" ,
                       limits = c(0,6000),
                       breaks = seq(0,6000,1000)) + 
    scale_fill_manual(name = "pHe", values = c('#9e9ac8','#addd8e','#dadada', '#d4aa00')) + 
    theme_woodn()



ph7.consolidated <- bind_rows(ph7.4hr.data,ph7.12hr.data)
ph7b.consolidated <- bind_rows(ph7b.4hr.data,ph7b.12hr.data)
ph6.consolidated <- bind_rows(ph6.4hr.data,ph6.12hr.data)

ggplot(data = ph6.consolidated) + 
    geom_boxplot(aes(x = time, y = fwhm), fill = '#9e9ac8',
                 outlier.shape = NA) + 
    geom_jitter(aes(x = time, y = fwhm,),
                width = 0.15, alpha = 0.4, cex = 4) + 
    scale_x_discrete(name = 'pHe 6.5-6.8', labels = c('Hour 4','Hour 12'))+
    scale_y_continuous(name =expression(bold(FWHM) ~ (bold(mu * m))),
                       limits = c(0,2.5)) + 
    theme_woodn()
