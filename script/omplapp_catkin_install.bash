#!/bin/bash
set -e  # exit on first error
ROS_VERSION="indigo"
ROS_BASH="/opt/ros/$ROS_VERSION/setup.bash"

install_prerequisites()
{
	# install prerequisites
	sudo apt-get install -y \
		gcc \
		g++ \
		make \
		build-essential 
}

install_libccd_and_fcl()
{
	wget -O - https://github.com/danfis/libccd/archive/v2.0.tar.gz | tar zxf - ;
        cd libccd-2.0;
        cmake .;
        sudo make install;
        cd ..;
        wget -O - https://github.com/flexible-collision-library/fcl/archive/0.4.0.tar.gz | tar zxf - ;
        cd fcl-0.4.0;
        cmake .;
        sudo make install;
        cd ..;
}

install_dependencies()
{
	install_prerequisites

	mkdir -p build_deps
	cd build_deps
	install_libccd_and_fcl
	cd ..
	rm -rf build_deps

}



build_omplapp()
{
	# setup ros env
	source $ROS_BASH

	# create catkin workspace
	mkdir -p $HOME/catkin_ws/src
	cd $HOME/catkin_ws/src
	git clone --depth=1 --branch=master https://github.com/ethz-asl/catkin_simple.git
	catkin_init_workspace
	cd -

	# setup catkin workspace
	cd $HOME/catkin_ws/
	catkin_make
	source devel/setup.bash
	cd -

	# copy omplapp_catkin to catkin workspace
	cd ..
	cp -R omplapp_catkin $HOME/catkin_ws/src
	cd $HOME/catkin_ws/
	
	catkin_make
}


# RUN
install_dependencies
build_omplapp
