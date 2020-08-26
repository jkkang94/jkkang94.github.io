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



######################################################################
#rf_rfe <- c("c_wid","KAL","c_hei","Axial_Length","K_MEAN","K2","R_SE_MM","K1_D","K1_mm","K2_mm","ACDAL","Spherical_Equivalent_pre","ACD","age","IOP_pre","sex","Cyl_D","CCT")
# 18
#lm_fre <- c("K2_mm","ACD","Axial_Length","c_hei","R_SE_MM","CCT","c_wid","K1_mm","K_MEAN","Cyl_D","ACDAL","DM","HTN","sex","a_cons","KAL","K1_D")
# 17
#svm_rfe, treebagrfe, lda_rfe -> 전체 선택 24
# "c_wid","KAL","c_hei","Axial_Length","K_MEAN" 모든 rfe best 5!
