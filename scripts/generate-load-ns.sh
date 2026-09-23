#!/bin/bash

BASE_URL="http://localhost:3001"
REQUESTS=100

ENDPOINTS=(
    "/"
    "/customers"
    "/health"
    "/warning"
    "/error"
    "/slow"
)

echo "========================================"
echo "Starting continuous traffic generation"
echo "100 requests per endpoint every minute"
echo "========================================"
echo "Press Ctrl+C to stop."
echo ""

while true
do
    START_TIME=$(date +%s)

    for ENDPOINT in "${ENDPOINTS[@]}"
    do
        echo ""
        echo "========================================"
        echo "Sending $REQUESTS requests to $ENDPOINT"
        echo "========================================"

        COMPLETED=0

        for ((i=1; i<=REQUESTS; i++))
        do
            curl -s -o /dev/null "${BASE_URL}${ENDPOINT}"

            COMPLETED=$((COMPLETED + 1))

            echo "$ENDPOINT → $COMPLETED/$REQUESTS completed"
        done

        echo ""
        echo "✅ $ENDPOINT → $COMPLETED requests completed"
    done

    END_TIME=$(date +%s)
    ELAPSED=$((END_TIME - START_TIME))

    echo ""
    echo "========================================"
    echo "Cycle completed!"
    echo "Total: 600 requests"
    echo "Time taken: ${ELAPSED} seconds"
    echo "========================================"

    if [ "$ELAPSED" -lt 60 ]; then
        SLEEP_TIME=$((60 - ELAPSED))
        echo "Waiting $SLEEP_TIME seconds for next cycle..."
        sleep "$SLEEP_TIME"
    else
        echo "Cycle took more than 60 seconds."
        echo "Starting next cycle immediately..."
    fi
done