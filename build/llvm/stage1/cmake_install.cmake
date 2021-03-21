# Install script for directory: /home/runner/work/tc-build/tc-build/llvm-project/llvm

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xllvm-headersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES
    "/home/runner/work/tc-build/tc-build/llvm-project/llvm/include/llvm"
    "/home/runner/work/tc-build/tc-build/llvm-project/llvm/include/llvm-c"
    FILES_MATCHING REGEX "/[^/]*\\.def$" REGEX "/[^/]*\\.h$" REGEX "/[^/]*\\.td$" REGEX "/[^/]*\\.inc$" REGEX "/LICENSE\\.TXT$")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xllvm-headersx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES
    "/home/runner/work/tc-build/tc-build/build/llvm/stage1/include/llvm"
    "/home/runner/work/tc-build/tc-build/build/llvm/stage1/include/llvm-c"
    FILES_MATCHING REGEX "/[^/]*\\.def$" REGEX "/[^/]*\\.h$" REGEX "/[^/]*\\.gen$" REGEX "/[^/]*\\.inc$" REGEX "/CMakeFiles$" EXCLUDE REGEX "/config\\.h$" EXCLUDE)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xcmake-exportsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/llvm" TYPE FILE FILES "/home/runner/work/tc-build/tc-build/build/llvm/stage1/lib/cmake/llvm/LLVMConfigExtensions.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/lib/Demangle/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/lib/Support/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/lib/TableGen/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/TableGen/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/include/llvm/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/lib/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/FileCheck/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/PerfectShuffle/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/count/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/not/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/yaml-bench/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/projects/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/tools/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/runtimes/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/examples/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/lit/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/test/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/unittests/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/unittest/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/docs/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/cmake/modules/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/llvm-lit/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/benchmark/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/benchmarks/cmake_install.cmake")
  include("/home/runner/work/tc-build/tc-build/build/llvm/stage1/utils/llvm-locstats/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/runner/work/tc-build/tc-build/build/llvm/stage1/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
