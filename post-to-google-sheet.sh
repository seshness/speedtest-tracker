#!/bin/bash -x

ACCESS_TOKEN=$(./get-access-token.sh ./service-account-key.json https://www.googleapis.com/auth/spreadsheets)

google_sheet_id="1jPdl7lS663gipdTxABtGIJ-ugSz5LNZOJ0dXSwLMQX4"
file_path_to_post=$1

curl --request POST \
  "https://sheets.googleapis.com/v4/spreadsheets/$google_sheet_id/values/A1:append?includeValuesInResponse=true&insertDataOption=INSERT_ROWS&responseDateTimeRenderOption=FORMATTED_STRING&responseValueRenderOption=UNFORMATTED_VALUE&valueInputOption=USER_ENTERED&alt=json" \
  --header "Authorization: Bearer $ACCESS_TOKEN" \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data-binary @"$file_path_to_post" \
  --compressed
