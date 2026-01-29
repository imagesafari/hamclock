#!/bin/bash
# Serve the HamClock archive locally
# Usage: ./serve.sh [port]

PORT="${1:-8080}"
cd "$(dirname "$0")/www"
echo "Serving HamClock archive at http://localhost:$PORT"
python3 -m http.server "$PORT"
