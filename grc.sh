#!/bin/bash
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PYTHONPATH="/opt/local/lib/python2.7/site-packages"
export PATH="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH"
export PATH="/Users/node/Applications/baudline.app/Contents/MacOS:$PATH"

cd /Users/node/sdr
/opt/local/bin/gnuradio-companion
