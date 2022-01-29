#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# Libraries and helpers
library(httpuv)
library(forecast)
source_  <- function(path) {
    invisible(sapply(list.files(path, full.names = TRUE), source))
}

# Get PORT from arguments or default to 80
PORT <- 80

if (length(args) > 0) {
  PORT <- as.integer(args[1])
}


# Source other code
source_("./R/utils/")
source_("./R/routing/")




router <- function (routes, request) {
  if (!request$PATH_INFO %in% names(routes)) {
    return(http_404)
  }
  path_handler <- routes[[request$PATH_INFO]]

  method_handler <- path_handler[[request$REQUEST_METHOD]]

  return(method_handler(request))
}

app <- list(
  call = function(request) {
    cat(paste0("Request to ", request$PATH_INFO, "\n"))

    response <- router(routes, request)

    return(create_response(response))
  }
)

cat(paste0("Server listening on: ", PORT, "...\n"))
runServer("0.0.0.0", PORT, app)