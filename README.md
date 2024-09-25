# example-plugin-sh
Example Streamrun plugin implemented as a shell script using gst-launch-1.0

## Concept
Streamrun plugins run in isolated Docker containers. The plugin receives audio or video buffers from the Streamrun platform, manipulates them as needed, and sends them back to the platform. Communication is done over TCP with a GStreamer Data Protocol (GDP) payload. The Streamrun platform automatically handles latency and synchronization issues.

Plugins are deployed by copying the manifest.json file to the Streamrun editor.

## Run the plugin locally
Install the latest GStreamer and run
```bash
./plugin.sh
```

## Build and run the plugin in a container
Build the Docker image
```bash
docker build -t streamrun-example-plugin-sh:0.1 .
```

Start a TCP server that will receive buffers from your plugin and display them in an autovideosink.
```bash
gst-launch-1.0 tcpserversrc host=0.0.0.0 port=3000 ! gdpdepay ! autovideosink
```

Run the Docker image that produces video using videotestsrc, passes the video through plugin.sh, and sends the GDP-payload buffers to the TCP server started above.
```bash
docker run -it --rm \
    -e STREAM_IN="videotestsrc is-live=true ! video/x-raw, width=1920, height=1080, framerate=60/1, format=I420" \
    -e STREAM_OUT="queue ! gdppay ! tcpclientsink host=host.docker.internal port=3000" \
    streamrun-example-plugin-sh:0.1
```