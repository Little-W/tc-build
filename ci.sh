#!/usr/bin/env bash

BASE=$(dirname "$(readlink -f "${0}")")
install=~/install/

set -eu


function parse_parameters() {
    while ((${#})); do
        case ${1} in
            all | deps | upload ) ACTION=${1} ;;
            *) exit 33 ;;
        esac
        shift
    done
}

function do_all() {
    do_deps
    do_upload
}

function do_deps() {
    # We only run this when running on GitHub Actions
    sudo apt update
    sudo apt install -y --no-install-recommends \
        bc \
        bison \
        ca-certificates \
        clang-13 \
        llvm-13 \
        cmake \
        curl \
        file \
        flex \
        gcc \
        g++ \
        git \
        libelf-dev \
        libssl-dev \
        lld \
        make \
        ninja-build \
        python3 \
        texinfo \
        xz-utils \
        zlib1g-dev

    git config --global user.email "1405481963@qq.com"
    git config --global user.name "Little-W"
}

function do_upload() {

    rel_date="$(date "+%Y%m%d")" # ISO 8601 format
    clang_version="$(install/bin/clang --version | head -n1 | cut -d' ' -f4)"

    if [ -d "install" ]
    then
    # Generate build info
    git clone --depth 1 git@github.com:Little-W/Sakura-ClangBuiltLinux.git ~/cl/
    mv ~/cl/.git install/.git
    mv ~/cl/README.md install/README.md
    cd  install
    git add -A -f
    git commit -am "Update to $rel_date build (Clang Version: $clang_version)"
    git push 
    else 
         git remote set-url origin git@github.com:Little-W/tc-build.git
         git add build/ 
       	 git commit -m "upload build cache $rel_date"
     	 git push
    fi
        
}

parse_parameters "${@}"
do_"${ACTION:=all}"
