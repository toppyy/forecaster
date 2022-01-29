
# Creates a "response"
# by adding default headers if they do not exists

create_response <- function(
                    response,
                    status = 200,
                    content_type = "text/plain"
                    ) {

    if (!"status" %in% names(response)) {
      response$status <- status
    }
    if (!"headers" %in% names(response)) {
      response$headers <- list()
    }
    if (!"Content-Type" %in% names(response$headers)) {
      response$headers[["Content-Type"]] <- content_type
    }
    response
}