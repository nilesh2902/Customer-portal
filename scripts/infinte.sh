#!/bin/bash

APP_PORT="${APP_PORT:-$(sed -n 's/^APP_PORT=//p' .env 2>/dev/null | tail -n 1)}"
BASE_URL="${BASE_URL:-http://localhost:${APP_PORT:-3001}}"
REQUESTS=100000000

echo "Generating error traffic against ${BASE_URL}/error"

for ((i=1; i<=REQUESTS; i++))
do
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}/error")

    if [ "$HTTP_CODE" = "000" ]; then
        echo "Request failed: could not connect to ${BASE_URL}/error"
        exit 1
    fi

    if (( i % 100 == 0 )); then
        echo "Generated $i requests. Last status: $HTTP_CODE"
    fi
done

echo "Generated $REQUESTS error requests."
