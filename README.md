# example-plugin-sh
Example Streamrun plugin implemented as a shell script using gst-launch-1.0

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

Start a TCP server that will receive buffers and display the video in an autovideosink.
```bash
gst-launch-1.0 tcpserversrc host=0.0.0.0 port=3000 ! gdpdepay ! autovideosink
````

Run the Docker image with videotestsrc as input and send output to the TCP server started above
```bash
docker run -it --rm \
    -e STREAM_IN="videotestsrc is-live=true ! video/x-raw, width=1920, height=1080, framerate=60/1, format=I420" \
    -e STREAM_OUT="queue ! gdppay ! tcpclientsink host=host.docker.internal port=3000" \
    streamrun-example-plugin-sh:0.1
```