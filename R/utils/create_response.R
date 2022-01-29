
# Creates a "response"
# by adding default headers if they do not exists

create_response <- function(response) {

    if (!"status" %in% names(response)) {
      response$status <- 200
    }
    if (!"headers" %in% names(response)) {
      response$headers <- list()
    }
    if (!"Content-Type" %in% names(response$headers)) {
      response$headers[["Content-Type"]] <- "text/plain"
    }
    response
}