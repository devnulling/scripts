#!/usr/bin/python

import os
import sys
import time

fileloc = sys.argv[1]
fno = fileloc.replace(".voc","")

workdir = "/tmp/samples/%s" % fno


for filename in os.listdir(workdir):
        print "PROCESSING FILE: " + filename
        os.system("/usr/bin/python2 " + "/home/user/iridium-toolkit/bits_to_dfs.py " + workdir + "/" + filename + " "+ workdir + "/" + filename.replace(".msg",".dfs"))
        os.system("/home/user/iridium-toolkit/ambe_emu/ambe -w " + workdir + "/" + filename.replace(".msg",".dfs"))


