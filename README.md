# example-plugin-sh
Example Streamrun plugin implemented as a shell script using gst-launch-1.0

Build the Docker image
```bash
docker build -t streamrun-example-plugin-sh:0.1 .
```

Run the Docker image with test input & output
```bash
gst-launch-1.0 tcpserversrc host=0.0.0.0 port=3000 ! gdpdepay ! autovideosink
docker run -it --rm \
    -e STREAM_IN="videotestsrc ! video/x-raw, width=1920, height=1080, framerate=60/1, format=I420" \
    -e STREAM_OUT="queue ! gdppay ! tcpclientsink host=host.docker.internal port=3000" \
    streamrun-example-plugin-sh:0.1
```