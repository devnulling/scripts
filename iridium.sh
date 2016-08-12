#!/bin/bash
today=`date '+%Y_%m_%d__%H_%M_%S'`;
filename="/home/user/iridium/$today.bits"
touch $filename
/usr/local/bin/iridium-extractor -D 4 /home/user/gr-iridium/examples/hackrf.conf > $filename
