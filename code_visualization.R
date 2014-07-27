require(caret)
require(ggplot2)

ids <- which(sapply(training, class) == 'factor')
wof.testing  <- testing[, -ids]
wof.training <- training[, -ids]

ggplot(data = training) + 
    aes(x = num_window, y = pitch_forearm, color = classe) +
    geom_point(alpha=0.3)

ggplot(data = training) + 
    aes(x = num_window, y = pitch_belt, color = classe) +
    geom_point(alpha=0.3)

ggplot(data = training) + 
    aes(x = num_window, y = magnet_dumbbell_z, color = classe) +
    geom_point(alpha=0.3)

wof.pca <- preProcess(wof.training, method = 'pca', thresh = .95)
wof.pc.train <- predict(wof.pca, wof.training)
wof.pc.test  <- predict(wof.pca, wof.testing)

ggplot(data = wof.pc.train) + 
    aes(x = PC1, y = PC2, color = training$classe) +
    geom_point(alpha=0.3)
