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

build_omplapp()
{
	# setup ros env
	source $ROS_BASH

	# create catkin workspace
	mkdir -p $HOME/catkin_ws/src
	cd $HOME/catkin_ws/src
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
install_prerequisites
build_omplapp
