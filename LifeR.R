setwd("~/Desktop/Kaggle/Life")

life_test <- read.csv("test.csv")
life_train <- read.csv("train.csv")

sample_submission <- read.csv("sample_submission.csv")

use_this <- life_train
second_this <- life_test

library(tidyverse)
library(caret)
mygrid <- expand.grid(mtry = 1, splitrule = 'maxstat', min.node.size = 10)
rf <- train(Response~Wt,
            data=(use_this[,c("Wt", "Response")]),
            method="ranger",
            metric = 'RMSE',
            trControl=trainControl(method="repeatedcv",
                                   number=10, 
                                   repeats=3),
            tuneGrid = mygrid
)

rf.preds <- data.frame(Id=second_this$Id, Response=round(predict(rf, newdata=second_this),digits = 0))
write_csv(x=rf.preds, file = ("life3.csv"))




