
library(ranger)
library(tidyverse)
library(ggplot2)
library(caret)
library(bst)

test_data <- read_rds("data/test.rds")
train_data <- read_rds("data/train.rds")

fitControl <- trainControl(method = "repeatedcv",
                           number = 5,
                           repeats = 5)
getModelInfo("ranger")
HP_rndFrst <- expand.grid(mtry = 17,
                               splitrule = "extratrees",
                               min.node.size = 5)

rndFrst <- train(score ~ PC1 + PC2 + PC3 + PC4 + PC5 + PC6,
                 data = PCA_traindata,
                 method = "ranger",
                 trControl = fitControl,
                 tuneGrid = HP_rndFrst
                 )
summary(rndFrst)
print(rndFrst)

HP_bst <- expand.grid(maxdepth = 2,
                      mstop = 50,
                      nu = 0.1)

bst <- train(score ~ PC1 + PC2 + PC3 + PC4 + PC5 + PC6,
            data = PCA_traindata,
            method = "bstTree",
            trControl = fitControl,
            tuneGrid = HP_bst)
summary(bst)
print(bst)

lnrRgr <- train(score ~ PC1 + PC2 + PC3 + PC4 + PC5 + PC6,
             data = PCA_traindata,
             method = "lm",
             trControl = fitControl)
summary(lnrRgr)
print(lnrRgr)

predict(rndFrst,
        newdata = test_data)
