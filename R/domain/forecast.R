
# Takes a time serie and returns a forecast for it
# timeserie = a numeric vector
# ... = addition arguments to forecast::forecast

forecast <- function(timeserie, ...) {


    fcast <- forecast::forecast(timeserie, ...)

    attributes <- c(
                    "mean",
                    "level",
                    "x",
                    "upper",
                    "lower",
                    "fitted",
                    "method",
                    "series",
                    "residuals"
                    )

    rtrn <- fcast[attributes]

    # Add a couple measures for fit from model
    # ("model" cannot be serialised to JSON entirely)
    rtrn["model"] <- list(fcast[["model"]][c("bic", "aicc", "mse", "amse")])

    return(rtrn)
}
