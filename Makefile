export PATH := $(HOME)/.poetry/bin:$(PATH)
export PATH := $(HOME)/miniconda3/bin:$(PATH)

install-ubuntu-latest: install-python-poetry-ubuntu install-python-dependencies
install-macOS-latest: install-python-poetry-macOS install-python-dependencies

install-python-poetry-ubuntu:
	sudo apt update
	sudo apt install curl wget python3.8 -y
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
	sudo apt install python3-distutils python3-apt python3-h5py -y
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
	
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
	chmod +x Miniconda3-latest-Linux-x86_64.sh

install-python-poetry-macOS:
	brew update
	ln -s -f /usr/local/bin/python3.8 /usr/local/bin/python3
	python3 -V
	pipx install poetry --python python3
	pipx install condax --python python3

install-python-dependencies:
	poetry install
	sudo conda install psi4=1.4rc3 python=3.8 -c psi4/label/dev -y

build:
	poetry run psi4 --test
	poetry run jupyter-book build ./qmlcourseRU