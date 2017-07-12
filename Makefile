.PHONY: pyside

pyside:
	docker build -t pymor/pyside_wheelbuilder:latest .
	docker run --rm -t -e LOCAL_USER_ID=$(shell id -u) -v ${PWD}:/io pymor/pyside_wheelbuilder:latest build-wheels.sh
	ls wheelhouse


