#!/bin/bash

dependencies=('sed' 'make' 'binutils' 'build-essential' 'gcc' 'g++' 'bash' 'patch' 'gzip' 'bzip2' 'perl' 'tar' 'cpio' 'unzip' 'rsync' 'file' 'bc' 'wget' 'python' 'git' 'ssh')

target_os="none"
target_os_installer=""
target_os_install_option=""
  
 function get_installer()
 {
	target_os=`hostnamectl | awk '/Operating System/ {print $3}'` 

	os_list_debian=("Debian" "Ubuntu" "Raspbian")
	os_list_redhat=("Centos" "Fedora" "RHEL")

 	for os in ${os_list_debian[@]}
	do
 		if [ ${target_os} == ${os} ]; then
 			echo "${os} OS detected"
 			target_os_installer="apt"
 			target_os_install_option="install"
 			return
 		fi
 	done

	for os in ${os_list_redhat[@]}
	do
	if [ ${target_os} == ${os} ]; then
		echo "${os} OS detected"
        target_os_installer="yum"
    	target_os_install_option="install"
		return
	fi
	done

	echo "os is not detected"
	target_os_installer="none"
	target_os_installer_option="none"
}

function install_dependencies()
{
	if [ ${target_os_installer} == "none" ]; then
		echo "cannot detect installer"
		return
	fi

	for dependency in ${dependencies[@]}
	do
		${target_os_installer} ${target_os_install_option} ${dependency}
	done
}


echo "########## get_installer call ##########"
get_installer

echo "########## install_dependencies call ###########"
install_dependencies
