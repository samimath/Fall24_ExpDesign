# example of multi-factor experiment
library(daewr)
library(effects)

##
prop <- web$signup / web$visitors
webp <- data.frame(web,prop)

modb0<-glm( cbind(signup, visitors-signup) ~ A * B * C * D,
            data = web, family = binomial )
modb <- glm( prop~ A * B * C * D,data = webp, 
             family = binomial('logit'), weights = visitors)

mod_effects1<-anova(update(modb, .~ A+B + A:B + C + 
               A:C + B:C + A:B:C + 
               D + A:D+B:D +C:D+ A:B:C:D ),test = 'Chisq')




## 3-way interaction plots


par ( mfrow = c(1,3) )
webp1 <- subset(webp, A == 1)
interaction.plot(webp1$C, webp1$D, webp1$prop, type = "l",
                   legend=FALSE, ylim = c(.015,.0275), main = "Background = 1",
                   xlab = "Text Color", ylab = "Proportion Signing-up")
webp2 <- subset(webp, A == 2 )
interaction.plot( webp2$C, webp2$D, webp2$prop, type = "l",
                    legend = FALSE, ylim = c(.015,.0275), main = "Background = 2",
                    xlab = "Text Color", ylab = " ")
lines( c(1.7,1.85), c(.016,.016), lty = 2)
lines( c(1.7,1.85), c(.017,.017) ,lty = 1)
text(1.3, .017, "Sign-up link  ")
text(1.3, .016, "Sign-up Button" )
text(1.4, .018, "LEGEND" )
webp3 <- subset(webp, A == 3)
interaction.plot(webp3$C, webp3$D, webp3$prop, type = "l",
                   legend=FALSE, ylim = c(.015,.0275), main="Background = 3",
                   xlab = "Text Color", ylab = " ")

## 3-way interaction plots using effects package
modbA_1 <- glm( cbind(signup, visitors-signup) ~ C*D ,data = subset(webp, A == 1), family = binomial)
plot(effects::allEffects(modbA_1), 
     main = 'background =1', 
     xlab = 'text color', ylab = 'P(sign-up)')

modbA_2 <- glm( cbind(signup, visitors-signup) ~ C*D ,data = subset(webp, A == 2), family = binomial)
plot(effects::allEffects(modbA_2), 
     main = 'background =1', 
     xlab = 'text color', ylab = 'P(sign-up)')


modbA_3 <- glm( cbind(signup, visitors-signup) ~ C*D ,data = subset(webp, A == 3), family = binomial)
plot(effects::allEffects(modbA_3), 
     main = 'background =1', 
     xlab = 'text color', ylab = 'P(sign-up)',ylim = c(0,0.03))


