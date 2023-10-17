
library(ranger)
library(tidyverse)
library(ggplot2)
library(bst)
library(caret)

test_data <- read_rds("data/test.rds")
train_data <- read_rds("data/train.rds")

set.seed(3456)

fitControl <- trainControl(method = "repeatedcv",
                           number = 5,
                           repeats = 5)
getModelInfo("ranger")
HP_rndFrst <- expand.grid(mtry = 17,
                               splitrule = "variance",
                               min.node.size = 5)

rndFrst <- train(score ~ .,
                 data = train_data,
                 method = "ranger",
                 trControl = fitControl,
                 tuneGrid = HP_rndFrst)
summary(rndFrst)
print(rndFrst)

rndFrst_PCA <- train(score ~ .,
                 data = PCA_traindata,
                 method = "ranger",
                 trControl = fitControl,
                 tuneGrid = HP_rndFrst
                 )
summary(rndFrst_PCA)
print(rndFrst_PCA)

HP_bst <- expand.grid(maxdepth = 1,
                      mstop = 150,
                      nu = 0.1)

bst <- train(score ~ .,
            data = train_data,
            method = "bstTree",
            trControl = fitControl,
            tuneGrid = HP_bst)
summary(bst)
print(bst)

bst_PCA <- train(score ~ .,
             data = PCA_traindata,
             method = "bstTree",
             trControl = fitControl,
             tuneGrid = HP_bst
             )
summary(bst_PCA)
print(bst_PCA)

predict(rndFrst,
        newdata = test_data)
