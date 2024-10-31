library(AlgDesign)
## splitplot design with two whole-plot factors
sp <- expand.grid(trayT = factor( c("RoomT", "Hot","Cold")),
                  bakeT = factor( c("low", "mid", "high") ))
## create whole-plots 
wp <- expand.grid(A = factor( c("A", "B")),
                  B = factor( c("C", "D") ))
## replicate whole-plots 
wp <- rbind(wp, wp)
## create design where there are two whole-plot factors
## and the rest are subplot factors including interaction
## blocksizes -num of subplots, num of whole-plots
splitP <- optBlock( ~ A *B* (trayT + bakeT +trayT:bakeT), 
                    withinData = sp, blocksizes = rep(9, 8),
                    wholeBlockData = wp)



sp1 <- expand.grid(C = factor(c("1","2","3")), D = factor(c("1","2","3")))
wp1 <- data.frame(A = factor(c("1","2")), B = factor(c("1","2")))
wp1 <- rbind(wp1,wp1)
wp1 <- rbind(wp1,wp1)
splitP1 <- optBlock(~ A*B * (C + D + C*D), withinData = sp1, 
                    blocksizes = rep(9,8),wholeBlockData = wp1)

