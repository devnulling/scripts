import os
total = 0
zeros = 0
notzeros = 0

os.system("mkdir -p good")
os.system("mkdir -p bad")
os.system("mkdir -p ugly")

def ckbyte(b):
	global total, zeros, notzeros
	if b == '\x00':
		zeros += 1
	else:
		notzeros += 1
	total += 1

def show(yo):
	#print "total bytes: %s" % total
	#print "total zeros: %s" % zeros
	#print "total non: %s" % notzeros
	zper = float(zeros)/float(total) * 100
	print "%s: %s" % (yo, zper)
	if zper > 98.0:
		cmd = "mv -v " + yo + " bad/"
		os.system(cmd)
	elif zper < 30.0:
		cmd = "mv -v " + yo + " good/"
		os.system(cmd)
	else:
		cmd = "mv -v " + yo + " ugly/"
		os.system(cmd)

def runfile(yo):
	f = open(yo, "rb")
	try:
	    byte = f.read(1)
	    while byte != "":
	        byte = f.read(1)
	        ckbyte(byte)
	finally:
	    f.close()
	show(yo)

for i in os.listdir(os.getcwd()):
	if i.endswith(".wav"): 
		runfile(i)
		total = 0
		zeros = 0
		notzeros = 0
		continue
	else:
		continue
