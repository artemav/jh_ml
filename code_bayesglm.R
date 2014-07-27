
require(caret)

## without factors

ids <- which(sapply(training, class) == 'factor')
wof.testing  <- testing[, -ids]
wof.training <- training[, -ids]

wof.pca <- preProcess(wof.training, method = 'pca', thresh = .95)
wof.pc.train <- predict(wof.pca, wof.training)
wof.pc.test  <- predict(wof.pca, wof.testing)

control <- trainControl(method = "cv", number = 10)

wof.model1 <- train(
    training$classe ~ .,
    data      = wof.training,
    method    = 'lda')

wof.model2 <- train(
    training$classe ~ .,
    data      = wof.pc.train,
    method    = 'lda',
    trControl = control)


