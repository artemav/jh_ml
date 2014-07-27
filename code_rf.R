require(caret)
require(randomForest)

pml.rf <- randomForest(classe ~ ., data = training, ntree = 100)
confusionMatrix(testing$classe, predict(pml.rf, testing))

importance_vars <- importance(pml.rf)
