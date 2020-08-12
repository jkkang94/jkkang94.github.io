rm(list=ls())
setwd("C:/Users/jkkan/Desktop/bitl")

dat <- read.csv("radiomics_fundus_ds.csv")
library(dplyr)
library(caret)
dat <- dat%>%select(-c("SID","OSOD"))
cl <- as.factor(dat$cl)

dat1 <- dat%>%select(-"cl")
#######################################################
source("kfold_validation.R")
fold <- makeFold(nrow(dat1), fld.k=10, getseed=100)  
acc <- kfold.c50(dat1, cl, get.trial=20, fold)
acc # 0.84984

acc<- kfold.RF(dat1, cl, get.ntree=500, fold)
acc # 0.85

acc<- kfold.svm(dat1, cl, kl="radial", fold)
acc  # 0.855722 

acc<- kfold.knn(dat1, cl, get.k=5, fold)
acc # 0.8054657

#########################################################

## create fold ######################################

makeFold <- function(range, fld.k=10, getseed=100) {
  set.seed(getseed)
  fld <- createFolds(1:range, k=fld.k)
  
  return (fld)
}
fold <- makeFold(nrow(dat), fld.k=10, getseed=100)  
acc1 <- c()
acc2 <- c()
acc3 <- c()
acc4 <- c()
outlier <- list()
normal <- list()
t <- c("glcm_inverseVariance", "calc_entropy", "calc_uniformity", "glcm_homogeneity1", "glcm_energy")
for (i in 1:length(fold)) {
  set.seed(100)
  # generate fold data
  dat1 <- dat%>%select(-"cl")
  ds.tr <- dat1[-fold[[i]],k]
  ds.ts <- dat1[fold[[i]],k]
  cl.tr <- as.factor(dat$cl[-fold[[i]]])
  cl.ts <- as.factor(dat$cl[fold[[i]]])
  
  #rf
  rand.fit <- randomForest(ds.tr , cl.tr , na.action = na.roughfix, ntree=500)
  pr.rand <- predict(rand.fit, ds.ts)
  
  acc1[i] <- mean(pr.rand==cl.ts)
  
  
  # xgboost
  #ds.tr_x <- as.matrix(ds.tr) 
  #ds.ts_x <- as.matrix(ds.ts)
  
  #xgb.fit <- xgboost(data = ds.tr_x[,-c(ncol(ds.tr_x))], label = ds.tr_x[,ncol(ds.tr_x)], 
  #                   nrounds = 149, eta=0.063,
  #                   max_depth=3, subsample=0.506, colsample_bytree=0.529,
  #                   gamma = 0.008, colsample_bylevel=0.941, lambda=0.005, alpha=0.299,
  #                   objective = "reg:linear")
  #pr.xgb <- predict(xgb.fit, ds.ts_x[,-c(ncol(ds.ts_x))])
  
  # GBM
  #gbm.fit = gbm(ds.tr$IOL_Ideal ~., data = ds.tr, distribution = "gaussian",
  #              cv.folds = 10, shrinkage = .01, n.minobsinnode = 10, n.trees = 500)
  #pr.gbm <- predict(gbm.fit, ds.ts)
  
  cat("rf fold",i,acc1[i], "\n")
  #cat("xgb fold",i,acc2[i], "\n")
  #cat("gbm fold",i,acc3[i], "\n")
  
  #ensemble
  #acc4[i] <- length(which(abs(r_pred_esb-ds.ts_$Spherical_Equivalent_post)<0.5))/length(r_pred_gbm)
  #cat("ensemble fold",i,acc4[i], "\n")
  
  #outlier
  #outlier[[i]] <- subset(ds.ts, abs(r_pred_xgb-ds.ts_$Spherical_Equivalent_post)>=0.5)
  #normal[[i]] <- subset(ds.ts, abs(r_pred_xgb-ds.ts_$Spherical_Equivalent_post)<0.5)
}
cat("acc ensemble:", mean(acc4))
cat("acc rf:", mean(acc1))
cat("acc xgb:", mean(acc2))


#####################
set.seed(100)
idx <- sample(1:nrow(dat), nrow(dat)*.2)
dat1 <- dat%>%select(-"cl")
ds.tr <- dat1[-idx,a]
ds.ts <- dat1[idx,a]
cl.tr <- as.factor(dat$cl[-idx])
cl.ts <- as.factor(dat$cl[idx])

rand.fit <- randomForest(ds.tr , cl.tr , na.action = na.roughfix, ntree=500)
pr.rand <- predict(rand.fit, ds.ts)
acc <- mean(pr.rand==cl.ts)

a <- data.frame(importance(rand.fit))
b <- sort(a$MeanDecreaseGini, decreasing = T)

t <- c("calc_uniformity", "glcm_cShade","calc_entropy","glcm_inverseVariance","glcm_maxProb")
head(rownames(a),20)
a$MeanDecreaseGini
sort(data.frame(importance(rand.fit))$MeanDecreaseGini,decreasing = T)
varImpPlot(rand.fit)
a <- importance(rand.fit)
a <- subset(a, a>3)

install.packages('MXM')
library(MXM)
install.packages("acepack")
library(acepack)
control <- rfeControl(functions = rfFuncs,
                      method = "repeatedcv",
                      repeats = 3,
                      verbose = FALSE)

Quote_Pred_Profile <- rfe(dat1[-idx,],as.factor(dat[-idx,"cl"]),
                          metric = "Accuracy",
                          maximizize = TRUE,
                          rfeControl = control)
plot(Quote_Pred_Profile)
#############################################################
# stepwise
library(MASS)
step(lm(cl~.,data=dat),direction="forward")
stepAIC(lm(cl~.,data=dat),direction="both")
k <-c("calc_energy","calc_entropy" ,"calc_skewness", 
        "calc_min", "calc_variance", "calc_RMS", "calc_sd", "glcm_variance", 
        "glcm_cShade", "glcm_cTendency", "glcm_correlation", "glcm_dissimilarity",
        "glcm_homogeneity1", "glcm_homogeneity2", "glcm_inverseVariance", 
        "glrlm_GLN", "glrlm_LRE", "glrlm_LRLGLE", "glrlm_LGLRE", "glrlm_SRE", 
        "glszm_SAE", "glszm_SZV", "glszm_ZP","glszm_HIE", "glszm_LISAE", 
        "glszm_HISAE","glszm_LILAE", "glszm_HILAE")
