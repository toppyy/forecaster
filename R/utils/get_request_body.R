

get_request_body <- function(request) {
    con     <- request$.bodyData
    content <- readLines(con)

    if (request[["CONTENT_TYPE"]] == "application/json") {
        content <- jsonlite::fromJSON(content)
    }
    return(content)
}