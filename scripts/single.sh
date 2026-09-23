#!/bin/bash

BASE_URL="http://localhost:3001"
ENDPOINT="/customers"

echo "========================================"
echo "Starting continuous traffic generation"
echo "Endpoint: $ENDPOINT"
echo "Press Ctrl+C to stop."
echo "========================================"

COUNT=0

while true
do
    curl -s -o /dev/null "${BASE_URL}${ENDPOINT}"

    COUNT=$((COUNT + 1))

    echo "$ENDPOINT → $COUNT requests completed"
done
