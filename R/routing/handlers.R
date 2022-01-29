cat("Sourced!\n")

http_404 <- list(
  status = 404,
  body = "404 Not Found"
)

root_handler <- list(
  GET = function(request) list(body = "Hello!!")
)



forecast_handler <- list(
  POST = function(request) {

    request_body  <- NULL
    response_body <- NULL

    tryCatch({
      request_body <- get_request_body(request)
    }, error = function(e) {
      cat("Could not parse body\n")
    })

    if (is.null(request_body)) {
      return(create_response(list(body = "Invalid request"), status = 400))
    }

    # Make forecast
    tryCatch({
      forecast_result <- forecast(request_body)
      response_body   <- jsonlite::toJSON(list(forecast = forecast_result))
    })

    if (is.null(response_body)) {
      return(create_response(list(body = "Invalid request"), status = 400))
    }

    create_response(
      list(body = response_body),
      content_type = "application/json"
    )
  }
)