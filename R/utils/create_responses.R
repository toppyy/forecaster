
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


# Convenience wrappers for some usual HTTP-responses

http_400 <- function() {
  create_response(list(body = "400 Invalid request"), status = 400)
}

http_404 <- function() {
  create_response(list(body = "404 Not Found"), status = 404)
}