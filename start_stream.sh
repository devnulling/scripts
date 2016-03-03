#!/bin/bash
screen -m -d cvlc -vvv alsa://hw:0,0 --sout '#rtp{sdp=rtsp://:8554/test.sdp}' --rtsp-host=<hostip> &
