.ONESHELL:
# SHELL = /bin/bash

export PATH := $(HOME)/.poetry/bin:$(PATH)

install-ubuntu-latest: install-python-poetry-ubuntu  install-psi4 install-python-dependencies
install-macOS-latest: install-python-poetry-macOS install-psi4 install-python-dependencies
install-windows: install-python-poetry-windows

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
	brew install poetry

	curl "http://vergil.chemistry.gatech.edu/psicode-download/Psi4conda-1.4rc3-py38-MacOSX-x86_64.sh" -o Psi4conda-1.4rc3-py38.sh --keepalive-time 2

install-python-poetry-windows:
	cmd //C curl https://www.python.org/ftp/python/3.8.5/python-3.8.5.exe --output "%TMP%\python-3.8.5.exe" 
	cmd //C "%TMP%\python-3.8.5.exe" /quiet InstallAllUsers=1 PrependPath=1 TargetDir="C:\Python38"
	cmd //C curl https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py --output "%TMP%\get-poetry.py"
	cmd //C python -V

	cmd //C python3 "c:/temp/get-poetry.py"
	cmd //C "%USERPROFILE%\.poetry\bin\poetry remove tensorflow-quantum"
	cmd //C "%USERPROFILE%\.poetry\bin\poetry install"

install-psi4:
	bash Psi4conda-1.4rc3-py38.sh -b -u -p $(HOME)/psi4conda

install-python-dependencies:
	poetry install

build:
	cd $(HOME)/psi4conda/etc/profile.d/ && source conda.sh && conda activate && cd - && poetry run psi4 --test
	poetry run jupyter-book build ./qmlcourseRU

build-windows:
	cmd //C "%USERPROFILE%\.poetry\bin\poetry run jupyter-book build ./qmlcourseRU"