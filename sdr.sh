#!/bin/bash

SDR_BASE_DIR="/home/$USER/sdr"
SDR_INSTALL_TARGET="$SDR_BASE_DIR/installs"


# pick a UHD tag
#SDR_UHD_VERSION="release_003_009_002"
#SDR_UHD_VERSION="release_003_009_006"
#SDR_UHD_VERSION="release_003_009_007"

#SDR_UHD_VERSION="release_003_010_000_000"
#SDR_UHD_VERSION="release_003_010_001_000"
#SDR_UHD_VERSION="release_003_010_002_000"
SDR_UHD_VERSION="release_003_010_003_000"
#SDR_UHD_VERSION="master"

# pick a GR tag
#SDR_GR_VERSION="v3.7.10.2"
SDR_GR_VERSION="master"

# set a UID for this install
#SDR_INSTALL_UID="release_003_010_002_000_gr_master"
SDR_INSTALL_UID="$SDR_UHD_VERSION"

# setup paths where stuff goes


SDR_INSTALL_BASE="$SDR_INSTALL_TARGET/$SDR_INSTALL_UID"

SDR_SRC_TARGET="$SDR_INSTALL_BASE/src"

SDR_UHD_SRC_BASE="$SDR_SRC_TARGET/uhd"
SDR_GR_SRC_BASE="$SDR_SRC_TARGET/gnuradio"






SDR_ENV_FILE="$SDR_INSTALL_BASE/setup.env"
SDR_OOT_DIR="$SDR_INSTALL_BASE/oots"
SDR_OOT_BUILDER_FILE="$SDR_OOT_DIR/oot.sh"
SDR_UHD_CMAKE="cmake -DCMAKE_INSTALL_PREFIX=$SDR_INSTALL_BASE ../"
SDR_GR_CMAKE="cmake -DCMAKE_INSTALL_PREFIX=$SDR_INSTALL_BASE -DUHD_DIR=$SDR_INSTALL_BASE/lib/cmake/uhd/ -DUHD_INCLUDE_DIRS=$SDR_INSTALL_BASE/include/ -DUHD_LIBRARIES=$SDR_INSTALL_BASE/lib/libuhd.so ../"


check_dir(){
	CURRENT_DIR=`pwd`
	echo "[ INFO ] Current Directory: $CURRENT_DIR"
}

create_dirs(){
	mkdir -p $SDR_BASE_DIR
	mkdir -p $SDR_SRC_TARGET
	mkdir -p $SDR_INSTALL_TARGET
	mkdir -p $SDR_INSTALL_BASE
	mkdir -p $SDR_UHD_SRC_BASE
	mkdir -p $SDR_OOT_DIR
		
}

install_uhd(){
	cd $SDR_UHD_SRC_BASE
	check_dir

	git clone https://github.com/ettusresearch/uhd $SDR_UHD_SRC_BASE
	
	
	cd "$SDR_UHD_SRC_BASE/"
	check_dir

	git checkout $SDR_UHD_VERSION
	
	cd "$SDR_UHD_SRC_BASE/host"
	check_dir

	mkdir -p "$SDR_UHD_SRC_BASE/host/build"
	cd "$SDR_UHD_SRC_BASE/host/build"

	check_dir

	eval $SDR_UHD_CMAKE
	
	make -j7
	
	make install

	source $SDR_ENV_FILE
	
	uhd_usrp_probe --version
	
	uhd_images_downloader
	
}

install_gr(){
	cd $SDR_GR_SRC_BASE
	check_dir

	git clone --recursive https://github.com/gnuradio/gnuradio $SDR_GR_SRC_BASE
	
	check_dir
	
	git checkout $SDR_GR_VERSION
	
	mkdir -p "$SDR_GR_SRC_BASE/build"
	cd "$SDR_GR_SRC_BASE/build"
	check_dir

	eval $SDR_GR_CMAKE
	make -j7
	make install
	gnuradio-config-info --version
	
}

write_env_file(){
	SDR_BASE_PATH="$SDR_INSTALL_BASE"
	SDR_PATH="$SDR_BASE_PATH/bin:$PATH"
	SDR_LD_LIBRARY_PATH="$SDR_BASE_PATH/lib:$LD_LIBRARY_PATH"
	SDR_PYTHONPATH_1="$SDR_BASE_PATH/lib/python2.7/site-packages:$PYTHONPATH"
	SDR_PYTHONPATH_2="$SDR_BASE_PATH/lib/python2.7/dist-packages:$PYTHONPATH"
	SDR_PKG_CONFIG="$SDR_BASE_PATH/lib/pkgconfig:$PKG_CONFIG_PATH"


	echo "Writing Environment File: $SDR_ENV_FILE"
	echo "export BASE_PATH=$SDR_BASE_PATH" > $SDR_ENV_FILE
	echo "export PATH=$SDR_PATH" >> $SDR_ENV_FILE
	echo "export LD_LIBRARY_PATH=$SDR_LD_LIBRARY_PATH" >> $SDR_ENV_FILE
	echo "export PYTHONPATH=$SDR_PYTHONPATH_1" >> $SDR_ENV_FILE
	echo "export PYTHONPATH=$SDR_PYTHONPATH_2" >> $SDR_ENV_FILE
	echo "export PKG_CONFIG_PATH=$SDR_PKG_CONFIG" >> $SDR_ENV_FILE
}

write_oot_builder(){

	echo "Writing OOT Builder"

	echo "#!/bin/bash" > $SDR_OOT_BUILDER_FILE
	echo "SDR_INSTALL_BASE=\"$SDR_INSTALL_BASE\"" >> $SDR_OOT_BUILDER_FILE
	echo "SDR_CMAKE_COMMAND=\"cmake -DCMAKE_INSTALL_PREFIX=\$SDR_INSTALL_BASE -DUHD_DIR=\$SDR_INSTALL_BASE/lib/cmake/uhd/ -DUHD_INCLUDE_DIRS=\$SDR_INSTALL_BASE/include/ -DUHD_LIBRARIES=\$SDR_INSTALL_BASE/lib/libuhd.so ../\"" >> $SDR_OOT_BUILDER_FILE
	echo "cd \$SDR_INSTALL_BASE" >> $SDR_OOT_BUILDER_FILE
	echo "source ./\$SDR_OOT_DIR/setup.env" >> $SDR_OOT_BUILDER_FILE
	echo "cd \$1" >> $SDR_OOT_BUILDER_FILE
	echo "mkdir build" >> $SDR_OOT_BUILDER_FILE
	echo "cd build" >> $SDR_OOT_BUILDER_FILE
	echo "eval \$SDR_CMAKE_COMMAND" >> $SDR_OOT_BUILDER_FILE
	echo "make -j7" >> $SDR_OOT_BUILDER_FILE
	echo "make install" >> $SDR_OOT_BUILDER_FILE
	chmod +x $SDR_OOT_BUILDER_FILE
}


create_dirs
write_env_file
write_oot_builder
install_uhd
install_gr
