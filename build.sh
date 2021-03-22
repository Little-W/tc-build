#!/usr/bin/env bash

export PATH=tc/bin:$PATH
export LD_LIBRARY_PATH=tc/lib:$LD_LIBRARY_PATH
./build-llvm.py \
        --no-update \
	--clang-vendor "Sakura" \
	--targets "ARM;AArch64;X86" \
	--shallow-clone \
	--lto thin \
	--incremental \
	--pgo
  #	--build-stage1-only \
#	--install-stage1-only \
 #	--projects "clang;compiler-rt;lld;polly" \
	#--branch "release/12.x" 

 
./build-binutils.py --targets arm aarch64 x86_64 
    # Remove unused products
    rm -fr install/include
    rm -f install/lib/*.a install/lib/*.la install/lib/clang/*/lib/linux/*.a*

for f in $(find install -type f -exec file {} \; | grep 'not stripped' | awk '{print $1}'); do
	strip ${f: : -1}
done

# Set executable rpaths so setting LD_LIBRARY_PATH isn't necessary
for bin in $(find install -mindepth 2 -maxdepth 3 -type f -exec file {} \; | grep 'ELF .* interpreter' | awk '{print $1}'); do
	# Remove last character from file output (':')
	bin="${bin: : -1}"

	echo "$bin"
	patchelf --set-rpath '$ORIGIN/../lib' "$bin"
done
