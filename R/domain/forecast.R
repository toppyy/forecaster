
# Takes a time serie and returns a forecast for it
# timeserie = a numeric vector
# ... = addition arguments to forecastlight::forecast

forecast <- function(timeserie, ...) {

    fcast <- forecastlight::forecast(timeserie, ...)

    attributes <- c(
                    "mean",
                    "level",
                    "x",
                    "upper",
                    "lower",
                    "fitted",
                    "method",
                    "residuals"
                    )

    rtrn   <- fcast[attributes]
    # Add forecast horizon
    rtrn$h <- length(rtrn[["mean"]])

    # Add a couple measures for fit from model
    # ("model" cannot be serialised to JSON entirely)
    rtrn["model"] <- list(fcast[["model"]][c("bic", "aicc", "mse", "amse")])

    return(rtrn)
}
