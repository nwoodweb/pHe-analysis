# NATHAN WOOD (contact@nwoodweb.xyz)
# TITRATION CURVE PLOTTING AND NUMERICAL SIMULATION
# MIT LICENSE

require(ggplot2)
require(titrationCurves)

hcl01 <- as.data.frame(read.csv('/home/woodn/Academic/phTitrationIteration01.csv'))
hcl02 <- as.data.frame(read.csv('/home/woodn/Academic/phTitrationIteration02.csv'))
hcl03 <- as.data.frame(read.csv('/home/woodn/Academic/phTitrationIteration03.csv'))

combined <- data.frame("ph01"=hcl01$ph, "ph02"=hcl02$ph, "ph03"=hcl03$ph)

combined$pHAvg <- rowMeans(combined)

for (i in 1:length(combined[,1])){
  combined$stdev[i] <- sd(c(combined$ph01[i],combined$ph02[i],combined$ph03[i]))
  
}
combined$mmolHcl <- hcl01$Hcl.mM.Added
combined$molLiter <- hcl01$media.mM.per.L
ggplot(data=combined) + 
  geom_point(aes(y=pHAvg,x=molLiter),cex=4,alpha=0.75) + 
  geom_errorbar(aes(ymin=pHAvg-stdev,ymax=pHAvg+stdev,x=molLiter),cex=1)+
  theme_woodn +
  xlab('HCl added (mM/L)') + 
  ylab('pH')

ggplot(data=combined,alpha=0.7) + 
  geom_point(aes(y=ph01,x=mmolHcl),col='red',cex=4,pch=16,alpha=0.7) +
  geom_point(aes(y=ph02,x=mmolHcl),col='blue',cex=4,pch=15,alpha=0.7) +
  geom_point(aes(y=ph03,x=mmolHcl),col='black',cex=4,pch=17,alpha=0.7) +
  theme_woodn +
  ylab('pH') +
  xlab('HCl added (mM/L)')
curve <- 0
curve <- diwb_sa(conc.base = 0.022,conc.acid = 2,pka2=6.1,pka3 = 3.5,pkw=14,
                 vol.base = 25,plot=F,eqpt = T)

head(curve)
curve$volume <- (((curve$volume * 1000) / 40 )) 
head(curve)
plot(curve) 


ggplot() + 
  geom_point(data=combined,aes(y=pHAvg,x=molLiter),cex=6,alpha=0.9) + 
  geom_errorbar(data=combined, aes(ymin=pHAvg-stdev,ymax=pHAvg+stdev,x=molLiter),cex=1)+
  xlab('HCl added (miliMol/L)') + 
  ylab('pH') + 
  ylim(c(0,8)) + 
  geom_line(data=curve,aes(x=volume,y=ph),cex=2,col='red') + 
  theme_woodn()
            
