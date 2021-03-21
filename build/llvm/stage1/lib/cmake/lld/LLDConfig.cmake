# This file allows users to call find_package(LLD) and pick up our targets.



find_package(LLVM REQUIRED CONFIG
             HINTS "/home/runner/work/tc-build/tc-build/build/llvm/stage1/lib/cmake/llvm")

set(LLD_EXPORTED_TARGETS "lldCommon;lldCore;lldDriver;lldMachO;lldYAML;lldReaderWriter;lld;lldCOFF;lldELF;lldMachO2;lldMinGW;lldWasm")
set(LLD_CMAKE_DIR "/home/runner/work/tc-build/tc-build/build/llvm/stage1/lib/cmake/lld")
set(LLD_INCLUDE_DIRS "/home/runner/work/tc-build/tc-build/llvm-project/lld/include;/home/runner/work/tc-build/tc-build/build/llvm/stage1/tools/lld/include")

# Provide all our library targets to users.
include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/lib/cmake/lld/LLDTargets.cmake")
