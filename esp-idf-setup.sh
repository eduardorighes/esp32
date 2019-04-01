#!/bin/bash

#
# Automate ESP32 development environment setup
# 

# Exit on any error

set -e

# User config

if [ -z ${PROJECTS_DIR} ]
then
	PROJECTS_DIR="${HOME}/projects/esp32"
fi

step()
{
	START="\e[104m"
	END="\e[0m"
	echo -e "${START} ---------- ${1} ---------- ${END}"
}

step "Project Configuration"

if [ -d "${PROJECTS_DIR}" ]
then
	echo "PROJECTS_DIR already exists; set to ${PROJECTS_DIR}"
	exit 1
fi

echo ${PROJECTS_DIR}

step "Creating Project Directory"

mkdir -p "${PROJECTS_DIR}"
cd "${PROJECTS_DIR}"

step "Installing Required Tools"

sudo apt-get -y install gcc git wget make libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-cryptography python-future python-pyparsing

step "Downloading Espressif Toolchain"

wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz

tar xzvf xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz

git clone --recursive https://github.com/espressif/esp-idf.git


export PATH=${PROJECTS_DIR}/xtensa-esp32-elf/bin:$PATH
export IDF_PATH=${PROJECTS_DIR}/esp-idf

step "Python Modules"

python -m pip install --user -r $IDF_PATH/requirements.txt

step "Profile Configuration"

echo "export PATH=${PROJECTS_DIR}/xtensa-esp32-elf/bin:$PATH" >> "${HOME}/.profile"
echo "export IDF_PATH=${PROJECTS_DIR}/esp-idf" >> "${HOME}/.profile"


