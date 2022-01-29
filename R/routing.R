http_404 <- list(
  status = 404,
  body = "404 Not Found"
)


root_handler <- list(
  GET = function(request) list(body = "Hello!!")
)

routes <- list(
  "/" = root_handler
)