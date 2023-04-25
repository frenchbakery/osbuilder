#!/usr/bin/sh
# shellcheck disable=SC2039
export CLR_RESET="\033[1;0m"
export STL_BOLD="\033[1;1m"
export CLR_RED="\033[0;31m"
export CLR_GREEN="\033[0;32m"
export CLR_BLUE="\033[0;34m"i


main()
{
    printf "%b::%b %bPython Installer%b\n" "$CLR_BLUE" "$CLR_RESET" "$STL_BOLD" "$CLR_RESET"

    printf "%b::%b creating temporary directory..." "$CLR_BLUE" "$CLR_RESET"
    tmp_dir="$(mktemp -d)"
    cd "$temp_dir"
    printf "\r%b::%b creating temporary directory %bdone%b\n" "$CLR_BLUE" "$CLR_RESET" "$CLR_GREEN" "$CLR_RESET"

    printf "%b::%b fetching newest python version..." "$CLR_BLUE" "$CLR_RESET"

    wget "http://endoflife.date/api/python.json" -q
    python_version="$(cat python.json | jq '.[0].latest' | sed 's/"//g')"
    
    printf "\r%b::%b fetching newest python version %b%s%b\n" "$CLR_BLUE" "$CLR_RESET" "$CLR_GREEN" "$python_version" "$CLR_RESET"

    printf "%b::%b downloading %bPython-%s.tgz%b ..." "$CLR_BLUE" "$CLR_RESET" "$CLR_GREEN" "$python_version" "$CLR_RESET"

    wget "https://www.python.org/ftp/python/$python_version/Python-$python_version.tgz -q"
    printf "%b::%b downloading %bPython-%s.tgz done%b" "$CLR_BLUE" "$CLR_RESET" "$CLR_GREEN" "$python_version" "$CLR_RESET"

    printf "%b::%b installing requirements" "$CLR_BLUE" "$CLR_RESET"

    sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev git
    
    tar "-xzvf Python-$python_version.tgz"
    cd "Python-$python_version/"
    
    printf "%b::%b enabling optimizations" "$CLR_BLUE" "$CLR_RESET"
    ./configure --enable-optimizations

    printf "%b::%b compiling" "$CLR_BLUE" "$CLR_RESET"
    sudo make altinstall -j3

    printf "%b::%b done%b" "$CLR_BLUE" "$CLR_GREEN" "$CLR_RESET"
}


main

