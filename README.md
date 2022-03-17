# Forecaster

An API that ingests timeseries and returns forecasts for them.

It has only one entrypoint and that is the root.

It expects something like this:

    {
        "data": [1,2,3,4,5,6,7,8,9,10,12,13,14,15],
        "h": 2
    }

Where *h* is number of observations one wants to get.

## Example

To test with cURL:

    docker-compose up --build

    echo '{ "data": [1,2,3,4,5,6,7,8,9,10,12,13,14,15],  "h": 2  }' > demo.json
    curl -d @demo.json -H "Content-Type: application/json" -X POST http://localhost:5000/forecast
