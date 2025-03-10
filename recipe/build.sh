#!/bin/sh

mkdir build
cd build

cmake .. \
      ${CMAKE_ARGS} \
      -G"Ninja" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib

ninja
ninja install
