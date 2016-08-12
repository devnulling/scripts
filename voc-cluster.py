#!/usr/bin/python
# vim: set ts=4 sw=4 tw=0 et fenc=utf8 pm=:

import sys
import matplotlib.pyplot as plt
import os
from sklearn.cluster import DBSCAN
import numpy

X = []
D = []
for line in open(sys.argv[1]):
    if 'VOC: ' in line:
        sl = line.split()
        #ts_base = int(sl[1].split('-')[1].split('.')[0])
        ts_base = 0
        ts = ts_base + int(sl[2])/1000.
        f = int(sl[3])/1000.
        X.append((ts, f))
        D.append(line)

D = numpy.array(D)
X = numpy.array(X)
print len(X)
db = DBSCAN(eps=20, min_samples=10).fit(X)

#bad_samples = X[db.labels_ == -1]
#fig = plt.figure()
#ax = fig.add_subplot(111)
#ax.scatter(x=[x[0] for x in bad_samples], y=[x[1] for x in bad_samples])
#ax.scatter(x=[x[0] for x in X], y=[x[1] for x in X], c=db.labels_ % 5)

non_voice_clusters = []
non_voice_lines = {}

for label in set(db.labels_):
    if label == -1:
        continue
    samples = D[db.labels_ == label]

    filename = "/tmp/samples/%d.msg" % label
    open(filename, "w").writelines(samples)
#    is_voice = os.system('check-sample ' + filename) == 0
    is_voice = 1
    if not is_voice:
        non_voice_cluster = X[db.labels_ == label]
        non_voice_clusters.append(non_voice_cluster)
        non_voice_cluster_tuples = tuple(map(tuple, non_voice_cluster))
        non_voice_lines.update(dict.fromkeys(non_voice_cluster_tuples, label))
        os.system('rm ' + filename)
