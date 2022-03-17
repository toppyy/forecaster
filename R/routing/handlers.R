
root_handler <- list(
  GET = function(request) list(body = "Hello!!")
)

forecast_handler <- list(
  POST = function(request) {


    if (request[["CONTENT_TYPE"]] != "application/json") {
      print(request[["CONTENT_TYPE"]])
      return(http_400())
    }

    request_body <- tryCatch({
      get_request_body(request)
    }, error = function(e) {
      print("Error with parsing request body: ")
      print(e)
      return(NULL)
      }
    )

    if (is.null(request_body)) {
      return(http_400())
    }

    timeserie <- request_body[["data"]]
    # Default forecast horizon is 2
    h <- ifelse(is.null(request_body[["h"]]), 2, request_body[["h"]])

    # Make forecast
    response_body <- tryCatch({
      jsonlite::toJSON(list(forecast = forecast(timeserie, h = h)))
    }, error = function(e) {
      print("Error with forecasting: ")
      print(e)
      return(NULL)
      }
    )

    if (is.null(response_body)) {
      return(http_400())
    }

    create_response(
      list(body = response_body),
      content_type = "application/json"
    )
  }
)