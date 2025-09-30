#!/bin/sh

mkdir build
cd build

export BUILD_NUMPY_INCLUDE_DIRS=$( $PYTHON -c "import numpy; print (numpy.get_include())")
export TARGET_NUMPY_INCLUDE_DIRS=$SP_DIR/numpy/core/include

echo $BUILD_NUMPY_INCLUDE_DIRS
echo $TARGET_NUMPY_INCLUDE_DIRS

if [[ $CONDA_BUILD_CROSS_COMPILATION == 1 ]]; then
  echo "Copying files from $BUILD_NUMPY_INCLUDE_DIRS to $TARGET_NUMPY_INCLUDE_DIRS"
  mkdir -p $TARGET_NUMPY_INCLUDE_DIRS
  cp -r $BUILD_NUMPY_INCLUDE_DIRS/numpy $TARGET_NUMPY_INCLUDE_DIRS
  export Python3_NumPy_INCLUDE_DIR=$TARGET_NUMPY_INCLUDE_DIRS
else
  export Python3_NumPy_INCLUDE_DIR=$BUILD_NUMPY_INCLUDE_DIRS
fi

cmake .. \
      ${CMAKE_ARGS} \
      -G"Ninja" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DBUILD_TESTING=OFF \
      -DBUILD_WITH_PROXQP=ON \
      -DPYTHON_EXECUTABLE=$PYTHON \
      -DPython3_NumPy_INCLUDE_DIR=$Python3_NumPy_INCLUDE_DIR \

ninja
ninja install

if [[ $CONDA_BUILD_CROSS_COMPILATION == 1 ]]; then
  echo $BUILD_PREFIX
  echo $PREFIX
  sed -i.back 's|'"$BUILD_PREFIX"'|'"$PREFIX"'|g' $PREFIX/lib/cmake/tsid/tsidTargets.cmake
  rm $PREFIX/lib/cmake/tsid/tsidTargets.cmake.back
fi
