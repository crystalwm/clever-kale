#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5f71952d8c45e90015c9c7cd/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5f71952d8c45e90015c9c7cd
fi
curl -s -X POST https://api.stackbit.com/project/5f71952d8c45e90015c9c7cd/webhook/build/ssgbuild > /dev/null
gatsby build
curl -s -X POST https://api.stackbit.com/project/5f71952d8c45e90015c9c7cd/webhook/build/publish > /dev/null
