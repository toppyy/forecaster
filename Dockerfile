FROM ubuntu:20.04

ENV TZ=Europe
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
        && apt-get install -y \
         r-base \
         r-base-dev \
         libssl-dev \
         libcurl4-openssl-dev

RUN Rscript -e "install.packages(c('httpuv','remotes','jsonlite','lmtest'), dependencies=TRUE, repos='http://cran.rstudio.com/')"

RUN Rscript -e "remotes::install_github('toppyy/forecastlight')"


WORKDIR /usr/forecaster

ENV LC_ALL=C.UTF-8 

COPY . .

CMD Rscript ./R/server.R $PORT 