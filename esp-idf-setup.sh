#!/bin/bash

#
# Automate ESP32 development environment setup
# 

set -e

PROJECTS_DIR="${HOME}/projects/esp32"

apt-get -y install gcc git wget make libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-cryptography python-future python-pyparsing

if [ ! -d "${PROJECTS_DIR}" ]
then
    mkdir -p "${PROJECTS_DIR}"
fi

cd "${PROJECTS_DIR}"

wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz

tar xzvf xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz

git clone --recursive https://github.com/espressif/esp-idf.git

export PATH=${PROJECTS_DIR}/xtensa-esp32-elf/bin:$PATH
export IDF_PATH=${PROJECTS_DIR}/esp-idf

echo "export PATH=${PROJECTS_DIR}/xtensa-esp32-elf/bin:$PATH" >> "${HOME}/.profile"
echo "export IDF_PATH=${PROJECTS_DIR}/esp-idf" >> "${HOME}/.profile"

python -m pip install --user -r $IDF_PATH/requirements.txt
