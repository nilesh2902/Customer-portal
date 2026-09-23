```bash
#!/bin/bash

APP_PORT="${APP_PORT:-$(sed -n 's/^APP_PORT=//p' .env 2>/dev/null | tail -n 1)}"
BASE_URL="${BASE_URL:-http://localhost:${APP_PORT:-3001}}"

# Requests for each endpoint
REQUESTS=20

# One endpoint is active for each minute
ENDPOINTS=(
    "/"
    "/customers"
    "/health"
    "/warning"
    "/error"
    "/slow"
)

echo "==============================================="
echo "Starting Traffic Generation"
echo "Base URL : $BASE_URL"
echo "Requests : $REQUESTS per endpoint"
echo "Duration : 6 minutes"
echo "==============================================="

TOTAL=0

for ENDPOINT in "${ENDPOINTS[@]}"
do
    echo ""
    echo "==============================================="
    echo "Sending $REQUESTS requests to: $ENDPOINT"
    echo "==============================================="

    START_TIME=$(date +%s)

    # Send 20 requests
    for ((i=1; i<=REQUESTS; i++))
    do
        printf "\r[%2d/%2d] GET %s" "$i" "$REQUESTS" "$ENDPOINT"

        curl -s -o /dev/null \
            "${BASE_URL}${ENDPOINT}" \
            > /dev/null

        TOTAL=$((TOTAL + 1))
    done

    echo ""
    echo "✔ Completed: $ENDPOINT"

    # Keep this endpoint's time window at 1 minute
    END_TIME=$(date +%s)
    ELAPSED=$((END_TIME - START_TIME))

    if [ "$ELAPSED" -lt 60 ]; then
        sleep $((60 - ELAPSED))
    fi
done

echo ""
echo "==============================================="
echo "Traffic Generation Completed"
echo "==============================================="
echo ""
echo "Traffic Distribution:"
echo ""
echo "Minute 1 → GET /           → 20 requests"
echo "Minute 2 → GET /customers  → 20 requests"
echo "Minute 3 → GET /health     → 20 requests"
echo "Minute 4 → GET /warning    → 20 requests"
echo "Minute 5 → GET /error      → 20 requests"
echo "Minute 6 → GET /slow       → 20 requests"
echo ""
echo "Total Requests Sent : $TOTAL"
echo "==============================================="
```
