#!/bin/bash
if pidof -x ffmpeg > /dev/null; then
    exit 1
fi

ffmpeg \
    -f v4l2 -thread_queue_size 8192 -input_format yuyv422 \
    -video_size 1280x720 -framerate 30 \
    -i /dev/video0 \
    -c:v h264_omx -b:v 768k \
    -bufsize 768k -vsync 1 -g 10 \
    -f flv rtmp://localhost/rtmplive/stream
