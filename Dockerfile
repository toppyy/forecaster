FROM ubuntu:20.04

ENV TZ=Europe
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
        && apt-get install -y \
         r-base \
         r-base-dev \
         libssl-dev \
         libcurl4-openssl-dev

RUN Rscript -e "install.packages(c('httpuv','forecast','jsonlite'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

WORKDIR /usr/forecaster

ENV LC_ALL=C.UTF-8 

COPY . .

CMD Rscript ./R/server.R $PORT 