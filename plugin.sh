#!/bin/bash

echo "Starting plugin..."
echo "STREAM_IN: $STREAM_IN"
echo "STREAM_OUT: $STREAM_OUT"

# If environment variables are not set, load from .env file
if [ -z "$STREAM_IN" ] || [ -z "$STREAM_OUT" ]; then
    source .env
fi

# Plugin code. Use videoflip to flip the video upside down
gst-launch-1.0 $STREAM_IN ! videoflip method=vertical-flip ! $STREAM_OUT