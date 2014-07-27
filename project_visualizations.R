## 
library(AppliedPredictiveModeling)
library(caret)

transparentTheme(trans = .9)
wof.training <- training[, -which(sapply(training[1,], class) == 'factor')]
featurePlot(x = wof.training,
            y = training$classe,
            plot = "density",
            scales = list(x = list(relation="free"),
                          y = list(relation="free")),
            adjust = 1.5,
            pch = "|",
            layout = c(5, 1),
            auto.key = list(columns = 3))

featurePlot(x = training[, 20:24], 
            y = training$classe,
            plot = "pairs")

featurePlot(x = training[, 10:15],
            y = training$classe,
            plot = "box")