#!/bin/sh

mkdir build
cd build

echo "python version:" $($PYTHON --version)
echo "python version:" $($(which python) --version)

cmake .. \
      ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_TESTING=OFF \
      -DPYTHON_EXECUTABLE=$PYTHON

make -j${CPU_COUNT}
make install
