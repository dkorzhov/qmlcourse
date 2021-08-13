.ONESHELL:
SHELL = /bin/bash

export PATH := $(HOME)/.poetry/bin:$(PATH)

install-ubuntu-latest: test install-python-poetry-ubuntu  install-psi4 install-python-dependencies
install-macOS-latest: test install-python-poetry-macOS install-psi4 install-python-dependencies
build: prepare-build build-main

install-python-poetry-ubuntu:
	sudo apt update
	sudo apt install curl wget python3.8 -y
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
	sudo apt install python3-distutils -y
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 

	curl "http://vergil.chemistry.gatech.edu/psicode-download/Psi4conda-1.4rc3-py38-Linux-x86_64.sh" -o Psi4conda-1.4rc3-py38.sh --keepalive-time 2

install-python-poetry-macOS:
	brew update
	ln -s -f /usr/local/bin/python3.8 /usr/local/bin/python3
	python3 -V
	pipx install poetry --python python3

	curl "http://vergil.chemistry.gatech.edu/psicode-download/Psi4conda-1.4rc3-py38-MacOSX-x86_64.sh" -o Psi4conda-1.4rc3-py38.sh --keepalive-time 2

install-psi4:
	bash Psi4conda-1.4rc3-py38.sh -b -u -p $(HOME)/psi4conda			

install-python-dependencies:
	poetry install

prepare-build:
	OLDPWD=$(shell pwd)
	cd $(HOME)/psi4conda/etc/profile.d/ && source conda.sh && conda activate
	cd $$OLDPWD

build-main:
	poetry run psi4 --test
	poetry run jupyter-book build ./qmlcourseRU

test:
	export OLDPWD=$(shell pwd)
	echo $$OLDPWD
	cd ..
	$(shell cd -)
	ls -la $$OLDPWD