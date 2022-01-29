
root_handler <- list(
  GET = function(request) list(body = "Hello!!")
)

forecast_handler <- list(
  POST = function(request) {

    if (request[["CONTENT_TYPE"]] != "application/json") {
      print(request[["CONTENT_TYPE"]])
      return(http_400())
    }

    request_body  <- NULL
    response_body <- NULL

    tryCatch({
      request_body <- get_request_body(request)
    }, error = function(e) {
      cat("Could not parse body\n")
    })

    if (is.null(request_body)) {
      return(http_400())
    }

    # Make forecast
    tryCatch({
      forecast_result <- forecast(request_body)
      response_body   <- jsonlite::toJSON(list(forecast = forecast_result))
    })

    if (is.null(response_body)) {
      return(http_400())
    }

    create_response(
      list(body = response_body),
      content_type = "application/json"
    )
  }
)