# Forecaster

An API that ingests timeseries and returns forecasts for them.

To test with cURL:

    docker-compose up --build

    curl -d "[1,2,3,4,5,6,7,8,9,10,12,13,14,15]" -H "Content-Type: application/json" -X POST http://localhost:5000/forecast
