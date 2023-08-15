#!/usr/bin/env bash
set -Eeuo pipefail

docker compose up -d --no-build

echo -e "\nWait for the UI to start then point your browser to: http://localhost:$(docker compose ps --status running --format json | sed -e 's/.*"PublishedPort":\([0-9]\+\),.*/\1/g') \n\n"
echo "To stop showing the logs precc CTRL-C"
$compose logs -f