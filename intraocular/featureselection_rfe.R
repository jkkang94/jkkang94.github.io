library(caret)
library(MASS)
library(kernlab)
library(mlbench)
ds <- rbind(train,test)
## rf_rfe

# define the control using a random forest selection function
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
# run the RFE algorithm
results <- rfe(ds[,1:24], ds[,25], sizes=c(1:24), rfeControl=control)
# summarize the results
print(results)
# list the chosen features
predictors(results)
# plot the results
plot(results, type=c("g", "o"))
rf_rfe <- predictors(results)

# lm_rfe
control <- rfeControl(functions= lmFuncs,
                      number = 200, method="cv")
results <- rfe(ds[,1:24], ds[,25], sizes=c(1:24), rfeControl=control)
print(results)
predictors(results)
plot(results, type=c("g", "o"))
lm_rfe <- predictors(results)

# treebag_rfe
control <- rfeControl(functions= treebagFuncs,method="cv", number=10)
results <- rfe(ds[,1:24], ds[,25], sizes=c(1:24), rfeControl=control)
print(results)
predictors(results)
plot(results, type=c("g", "o"))
treebag_rfe <- predictors(results)

# svm_rfe
control <- rfeControl(functions= caretFuncs,method="cv", number=10)
results <- rfe(ds[,1:24], ds[,25], sizes=c(1:24), rfeControl=control, method="svmRadial")
print(results)
predictors(results)
plot(results, type=c("g", "o"))
svm_rfe <- predictors(results)

# lda_rfe
control <- rfeControl(functions=ldaFuncs,method="cv", number=10)
results <- rfe(ds[,1:24], ds[,25], sizes=c(1:24), rfeControl=control)
print(results)
predictors(results)
plot(results, type=c("g", "o"))
lda_rfe <- predictors(results)
