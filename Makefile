.PHONY: pyside
pyside:
	docker build -t pymor/pysidewheel:3.4 pyside_docker/
	docker run --rm -t -e LOCAL_USER_ID=$(shell id -u) -e PYVER="cp34-cp34m" -v ${PWD}:/io pymor/pysidewheel:3.4 /usr/local/bin/build-wheels.sh


