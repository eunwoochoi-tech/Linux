#!/bin/bash

target_ubuntu="ubuntu"
target_centos="centos"
target_all=(${target_ubuntu} ${target_centos})
parameter_count=$#
parameter_all=$@

function ubuntu()
{
	parameter_perm=$1

	echo "target is ubuntu"
	echo "installing cross-compile dependencies..."

	if [ ${parameter_perm} == "root" ]; then
		apt install build-essential lzop u-boot-tools net-tools bison flex libssl-dev libncurses5-dev libncursesw5-dev unzip chrpath xz-utils minicom -y
	elif [ ${parameter_perm} == "user" ]; then
		sudo apt install build-essential lzop u-boot-tools net-tools bison flex libssl-dev libncurses5-dev libncursesw5-dev unzip chrpath xz-utils minicom -y
	else
		echo "invalid permission ${parameter_perm}"
		exit -1
	fi
	
	echo "install done!"
}

function centos()
{
	echo "this is centos"
}

function install()
{
	parameter_os=$1
	parameter_perm=$2

	# check parameter(os) and execute adequate function
	for target in ${target_all[@]}
	do
		if [ ${parameter_os} == ${target} ]; then
			${target} ${parameter_perm}
		fi
	done
}

# Check if parameter count is 1
if [ ${parameter_count} != 2 ]; then
	echo "Usage : <$0> <OS> <permisson>"
	exit -1
fi

# call the install function passing parameter
install $@
