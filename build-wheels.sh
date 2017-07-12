#!/bin/bash
set -e -x

WHEEL_DIR=/io/wheelhouse

PYS="cp26-cp26m cp26-cp26mu cp27-cp27m cp27-cp27mu cp33-cp33m cp34-cp34m cp35-cp35m cp36-cp36m"
PYS="cp33-cp33m cp34-cp34m"

cd /io/pyside_src
for PY in ${PYS}; do
    PYBIN=/opt/python/${PY}/bin/
    ${PYBIN}/python setup.py build
    find . -name "libshiboken*so*" | sudo xargs  cp -t /usr/local/lib/ || echo blah
    ${PYBIN}/pip wheel /io/pyside_src -w ${WHEEL_DIR}/ -v
    sudo rm /usr/local/lib/libshiboken*
done

# Bundle external shared libraries into the wheels
for whl in ${WHEEL_DIR}/*.whl; do
    auditwheel repair $whl -w ${WHEEL_DIR}/
done

