#!/bin/bash
# simple bash script to install gnuradio OOTs on OSX with a Gnuradio macports install
FILE="CMakeLists.txt"

if grep -q "On Apple only" "$FILE"; then
	echo "APPLE STRING FOUND"; 
	echo "Making build dir"
	mkdir build
	cd build
	echo `pwd`
	echo "Running CMake"
	cmake -DCMAKE_INSTALL_PREFIX=/opt/local -DPYTHON_EXECUTABLE=/opt/local/bin/python2.7 -DPYTHON_INCLUDE_DIR=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Headers -DPYTHON_LIBRARY=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/Python ../
	echo "Building..."
	make
	echo "Installing..."
	sudo make install
	echo "Done."
	cd ..
else
	echo "Add Apple specific path names to CMakeLists.txt"
fi
