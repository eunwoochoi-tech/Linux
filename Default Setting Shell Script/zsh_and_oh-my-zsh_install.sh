#!/bin/bash

dependencies=("git" "wget" "zsh")
target_os="none"
target_installer="none"
target_installer_option="none"

github_file_url="https://raw.githubusercontent.com/eunwoochoi-tech/Linux/master/Default%20Setting%20Files/"
download_files=(".oh-my-zsh.tar.xz" ".zshrc")
oh_my_zsh_dir_name=".oh-my-zsh"
oh_my_zsh_idx=0
zshrc_idx=1

ZSH_CUSTOM="${HOME}/${oh_my_zsh_dir_name}/custom"

function get_installer()
{
    echo "########## 1. Detecting your os ##########"

	os_list_debian=("Debian" "Ubuntu" "Raspbian")
	os_list_redhat=("Centos" "Fedora" "RHEL")

    target_os=`hostnamectl | awk '/Operating System/ {print $3}'`  

    for os in ${os_list_debian[@]}
    do  
        if [ ${target_os} == ${os} ]; then
            target_installer="apt"
            target_installer_option="install"
        fi
    done
        
    for os in ${os_list_redhat[@]}
    do  
        if [ ${target_os} == ${os} ]; then
            target_installer="yum"
            target_installer_option="install"
        fi
    done

    echo "########## detected OS : ${target_os} ##########"
    echo "########## Installer : ${target_installer} ##########"
    echo "########## Installer Option : ${target_installer_option} ##########"
	echo ""; echo ""; echo"";
}


function install_dependencies()
{
	echo "########## 2. Install denpendencies ##########"

	for dependency in ${dependencies[@]}
	do
        echo "########## Install ${dependency} .... ##########"
        sudo ${target_installer} ${target_installer_option} ${dependency} -y
        echo "########## Install dependencies done ${dependency} .... ##########"
		echo ""
	done

	echo ""; echo ""; echo "";
}

function download_files()
{
	echo "########## 3. download files ##########"

	for file in ${download_files[@]}
	do
		echo "########## downloading ${file}... ##########"
		wget "${github_file_url}${file}"
	done

	echo ""; echo ""; echo "";
}

function extract_and_copy_to_home()
{
	echo "########## 4. extract and copy files to home ##########"

	tar -xJvf ${download_files[${oh_my_zsh_idx}]} > extract.log 2>&1
	if [ ! -d ${oh_my_zsh_dir_name} ]; then
		echo "########## error! there is no extracted directory ##########"
		exit
	fi

	cp -r ${oh_my_zsh_dir_name} ~
	cp ${download_files[${zshrc_idx}]} ~

	echo "########## extract and copy done ##########"
	echo ""; echo ""; echo"";
}

function make_soft_link()
{
	echo "########## 6. make soft link ##########"

	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

	echo "########## make soft link done ##########"
	echo ""; echo ""; echo"";
}

function change_default_shell()
{
	echo "########## 5. Changed Default Shell to zsh ##########"

	chsh -s `which zsh`
	zsh

	echo "########## Changed Default Shell to zsh done ##########"
	echo ""; echo ""; echo"";
}


# 1. detect os to get installer
get_installer

# 2. install dependencies
install_dependencies

# 3. download required files from github
download_files

# 4. extract and copy to home dir 
extract_and_copy_to_home

# 5. make soft link
make_soft_link

# 6. change default shell to zsh
change_default_shell


# export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"


