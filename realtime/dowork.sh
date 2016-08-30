#!/bin/bash
#rm /tmp/samples/*
name=$(basename "$1")
filenameonly="${name%.*}"

/usr/bin/python /home/user/iridium-toolkit/voc-cluster.py $1
#mkdir -p /tmp/samples/$filenameonly
/usr/bin/python /home/user/run.py $1

sleep 5
mkdir /home/user/vocs/$filenameonly

mv /tmp/samples/$filenameonly/*.wav /home/user/vocs/$filenameonly

cp /home/user/wav_parse.py /home/user/vocs/$filenameonly/wav_parse.py

cd /home/user/vocs/$filenameonly/

/usr/bin/python /home/user/vocs/$filenameonly/wav_parse.py

cd /home/user/vocs

tar zcvf "$filenameonly.tgz" $filenameonly

echo "$filenameonly.tgz"

