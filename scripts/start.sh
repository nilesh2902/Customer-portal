#!/bin/bash

export OTEL_SERVICE_NAME=demo-node-test-app

export OTEL_RESOURCE_ATTRIBUTES="deployment.environment=poc,service.version=1.0.0"

export OTEL_TRACES_EXPORTER=otlp
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp

export OTEL_EXPORTER_OTLP_PROTOCOL=http/protobuf

export OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://labs.codexray.io:8005/ingest/v1/traces
export OTEL_EXPORTER_OTLP_METRICS_ENDPOINT=http://labs.codexray.io:8005/ingest/v1/metrics
export OTEL_EXPORTER_OTLP_LOGS_ENDPOINT=http://labs.codexray.io:8005/ingest/v1/logs

export OTEL_EXPORTER_OTLP_HEADERS="x-api-key=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjIwOTMyNDI1MDQsImlhdCI6MTc3Nzg4MjUwNCwicHJvamVjdF9pZCI6ImNlNHl5MXRoIiwidGVuYW50X2lkIjoibWFtM3QweXUiLCJ0eXBlIjoicHJvamVjdF9hcGlfa2V5In0.QAwxcjKcE3dA8_WOthP8es5AfprqTIgk-Urhpe_zhGo,X-Metrics-Type=otel"

export OTEL_TRACES_SAMPLER=always_on
export OTEL_LOG_LEVEL=debug
export OTEL_NODE_RESOURCE_DETECTORS=env,host

echo "TRACES=$OTEL_EXPORTER_OTLP_TRACES_ENDPOINT"
echo "METRICS=$OTEL_EXPORTER_OTLP_METRICS_ENDPOINT"
echo "LOGS=$OTEL_EXPORTER_OTLP_LOGS_ENDPOINT"

NODE_OPTIONS="--require @opentelemetry/auto-instrumentations-node/register" node app.js
