#!/bin/sh

mkdir build
cd build

cmake .. \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DPython3_NumPy_INCLUDE_DIR=$TARGET_NUMPY_INCLUDE_DIRS \
      -DBUILD_TESTING=OFF \
      -DPYTHON_EXECUTABLE=$PYTHON

make -j${CPU_COUNT}
make install
