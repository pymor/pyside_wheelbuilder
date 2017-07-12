#!/bin/bash
set -e -x

if [ -z ${PYVER+x} ]; then
    PYVER="cp34-cp34m"
fi

# Compile wheels
PYBIN=/opt/python/${PYVER}/bin
WHEEL_DIR=/io/pyside_wheelhouse

cd /io/pyside_src
${PYBIN}/python setup.py build
find . -name "libshiboken*so*" | sudo xargs  cp -t /usr/local/lib/ || echo blah
${PYBIN}/pip wheel /io/pyside_src -w ${WHEEL_DIR}/ -v
# cd /usr/local/src/PySide-1.2.4
# ${PYBIN}/python setup.py bdist_wheel --qmake=/usr/lib/qt4/bin/qmake --standalone


# Bundle external shared libraries into the wheels
for whl in ${WHEEL_DIR}/*.whl; do
    auditwheel repair $whl -w ${WHEEL_DIR}/
done

