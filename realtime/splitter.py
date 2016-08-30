#!/usr/bin/python
import sys
import time
import thread
import os

def dowork(filename):
	print "DOING WORK: %s" % filename
	cmd = "/bin/bash /home/user/dowork.sh %s" % filename
	print "CMD: %s" % cmd
	os.system(cmd)
	print "dowork python done..."


voc_ct = 0

old_ts = int(time.time())
ts = old_ts

prev_ct = 0

filename = str(ts) + ".voc"
f = open(filename, 'w')

for line in sys.stdin:

	ts = int(time.time())

	if old_ts == ts:
		if "VOC" in line:
			voc_ct = voc_ct + 1
			f.write(line)

	else:
		if voc_ct == 0 and prev_ct != 0:
			f.close()
			thread.start_new_thread(dowork, (filename,))
			filename = str(ts) + ".voc"
			f = open(filename, 'w')

		print "TS: %s CT: %s FILE: %s" % (old_ts, voc_ct, filename)
		#f.close()
		old_ts = ts
		prev_ct = voc_ct
		voc_ct = 0

		if "VOC" in line:
			voc_ct = voc_ct + 1
			f.write(line)



