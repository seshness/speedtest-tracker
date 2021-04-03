#!/bin/bash -x

SPEEDTEST_RESULT_FILE="$(mktemp)"
GSHEETS_REQUEST_FILE="$(mktemp)"

speedtest --server-id=1783 --format=json > "$SPEEDTEST_RESULT_FILE"

jq \
  '{"values":[[.timestamp, .ping.jitter, .ping.latency, .download.bandwidth, .download.bytes, .download.elapsed, .upload.bandwidth, .upload.bytes, .upload.elapsed, .isp, .interface.internalIp, .interface.name, .interface.macAddr, .interface.isVpn, .interface.externalIp, .server.id, .server.name, .server.location, .server.country, .server.host, .server.port, .server.ip, .result.id, .result.url]]}' \
  "$SPEEDTEST_RESULT_FILE" \
  > "$GSHEETS_REQUEST_FILE"

./post-to-google-sheet.sh "$GSHEETS_REQUEST_FILE"
