library(caret)
library(MASS)
stepAIC(lm.fit, direction = "both", trace = FALSE)
stepAIC(lm.fit, direction = "backward", trace = FALSE)
stepAIC(lm.fit, direction = "forward", trace = FALSE)

