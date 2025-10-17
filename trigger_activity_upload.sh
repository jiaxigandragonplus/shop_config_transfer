#!/bin/bash

app=$1

curl -XPOST -H 'content-type: application/json' -H 'x-dragonplus-pipeline: upload-activity' https://pipeline-webhooks-dev.dragonplus.com -d \
"
{
    \"app_name\": \"$app\"
}
"
