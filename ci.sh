#!/usr/bin/env bash

BASE=$(dirname "$(readlink -f "${0}")")
install=~/install/

set -eu


function parse_parameters() {
    while ((${#})); do
        case ${1} in
            all | binutils | deps | upload | llvm) ACTION=${1} ;;
            *) exit 33 ;;
        esac
        shift
    done
}

function do_all() {
    do_deps
    do_llvm
    do_binutils
    do_upload
}

function do_binutils() {
    "${BASE}"/build-binutils.py --targets arm aarch64 x86_64 \
                                --install-folder "$install"

    cd ~/
    # Remove unused products
    rm -fr install/include
    rm -f install/lib/*.a install/lib/*.la

# Strip remaining products
    for f in $(find install -type f -exec file {} \; | grep 'not stripped' | awk '{print 	$1}'); do
	    strip ${f: : -1}
    done

# Set executable rpaths so setting LD_LIBRARY_PATH isn't necessary
    for bin in $(find install -mindepth 2 -maxdepth 3 -type f -exec file {} \; | grep 'ELF .* 		interpreter' | awk '{print $1}'); do
	# Remove last character from file output (':')
	    bin="${bin: : -1}"

    	echo "$bin"
	    patchelf --set-rpath '$ORIGIN/../lib' "$bin"
    done
}

function do_deps() {
    # We only run this when running on GitHub Actions
    [[ -z ${GITHUB_ACTIONS:-} ]] && return 0
    sudo brew update
    sudo brew install -y \
        bc \
        bison \
        ca-certificates \
        clang \
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
    git config --global user.password "Wyx200304060292"
    git config --global credential.helper store
  #  git clone https://github.com/Little-W/redentials.git ~/re
    cp -v "${BASE}"/.git-credentials ~/
}

function do_upload() {

    # Generate build info
	rel_date="$(date "+%Y%m%d")" # ISO 8601 format
	clang_version="$(install/bin/clang --version | head -n1 | cut -d' ' -f4)"
	
    git clone https://github.com/Little-W/clang ~/cl/
    cp -rf ~/cl/.git $install
    cd  $install
    git add .
    git commit -am "Update to $rel_date build (Clang Version: $clang_version)"
    git push
}

function do_llvm() {
    EXTRA_ARGS=()
    [[ -n ${GITHUB_ACTIONS:-} ]] && EXTRA_ARGS+=(--no-ccache)
    "${BASE}"/build-llvm.py \
        "${EXTRA_ARGS[@]}" \
	--install-folder "$install" \
	--clang-vendor "Sakura-$(date +%Y%m%d)" \
	--targets "ARM;AArch64;X86" \
	--shallow-clone \
	--build-stage1-only \
        --install-stage1-only \
	--projects "clang;compiler-rt;lld;polly" \
	--incremental \
	--lto thin
}

parse_parameters "${@}"
do_"${ACTION:=all}"
