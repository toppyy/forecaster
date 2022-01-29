FROM ubuntu:20.04

ENV TZ=Europe
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
        && apt-get install -y \
         r-base \
         r-base-dev

RUN apt-get install libssl-dev

RUN Rscript -e "install.packages(c('httpuv','forecast'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

WORKDIR /usr/forecaster

ENV LC_ALL=C.UTF-8 


CMD Rscript ./R/server.R $PORT 