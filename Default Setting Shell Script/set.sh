#!/bin/bash

root_path=$HOME
cur_path=`pwd`
target_vi='.vimrc'
target_tmux='.tmux.conf'
target_bash='.bashrc'
target_all=(${target_vi} ${target_tmux} ${target_bash})
target_all_cnt=0

parameter_cnt=$#
parameters=$@

function set()
{
    local parameter=$1
    if [ ${parameter} == "all" ]; then
        for target in "${target_all[@]}"
        do
            echo "TARGET : ${target}"
            set_configuration ${target}
        done
	elif [ ${parameter} == "bash" ]; then
		set_configuration ${target_bash}
	elif [ ${parameter} == "vi" ]; then
		set_configuration ${target_vi}
	elif [ ${parameter} == "tmux" ]; then
		set_configuration ${target_tmux}
    fi
}

function set_configuration()
{
    target=$1
	# Check if there were files in current directory
    if [ ! -f ${cur_path}/${target} ]; then
        echo "There is no ${target} file"
        echo "Downloading...."
        wget https://raw.githubusercontent.com/SexyEunwoo/Linux/master/Default%20Setting%20Files/${target}
        if [ ! -f ${cur_path}/${target} ]; then
            echo "Download Failed"
            exit -1
        fi
    fi

    # configure set .bashrc 
    if [ ${target} == ${target_bash} ]; then
        echo "Adding .bashrc content to ~/.bashrc"
        cat ${cur_path}/${target} >> ${root_path}/${target}
        echo "Adding Done!"
    fi

    # configure set .vimrc
    if [ ${target} == ${target_vi} ]; then
        echo "Copying ${target} file to home directory..."
        cp ${cur_path}/${target} ${root_path}
        echo "Copying Done!"

        echo "Vundle Plugin Download..."
        git clone https://github.com/VundleVim/Vundle.vim.git ${root_path}/.vim/bundle/Vundle.vim
        echo "Vundle Plugin Download Done!"
    fi

    # configure set .tmux.conf 
    if [ ${target} == ${target_tmux} ]; then
        echo "Copying ${target} file to home directory..."
        cp ${cur_path}/${target} ${root_path}
        echo "Copying Done!"
    fi
    #
}

# 1. Check Parameter Count( parameter is coming like "all" "vi" "tmux" etc.. )
if [ ${parameter_cnt} -eq 0 ]; then
    echo "Usage <Parameter1> <...>"
    exit -1
fi

# 2. send parameters to set function at a time
for parameter in ${parameters[@]}
do
    set ${parameter}
done  
