require(caret)

ids <- which(sapply(training, class) == 'factor')
wof.testing  <- testing[, -ids]
wof.training <- training[, -ids]

pca <- preProcess(wof.training, method = 'pca', thresh = .95)
pc.train <- predict(pca, wof.training)
pc.test  <- predict(pca, wof.testing)

control <- trainControl(method = "cv", number = 10)

wof.model1 <- train(
    training$classe ~ .,
    data      = wof.training,
    method    = 'lda')

wof.model2 <- train(
    training$classe ~ .,
    data      = pc.train,
    method    = 'lda',
    trControl = control)


