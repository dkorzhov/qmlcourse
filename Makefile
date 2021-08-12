export PATH := $(HOME)/.poetry/bin:$(PATH)

install-ubuntu-latest: install-python-poetry-ubuntu  install-psi4 install-python-dependencies
install-macOS-latest: install-python-poetry-macOS install-python-dependencies

install-python-poetry-ubuntu:
	sudo apt update
	sudo apt install curl wget python3.8 -y
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
	sudo apt install python3-distutils -y
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 
	
install-python-poetry-macOS:
	brew update
	ln -s -f /usr/local/bin/python3.8 /usr/local/bin/python3
	python3 -V
	pipx install poetry --python python3

install-psi4:
	# curl "http://vergil.chemistry.gatech.edu/psicode-download/Psi4conda-1.4rc3-py38-Linux-x86_64.sh" -o Psi4conda-1.4rc3-py38-Linux-x86_64.sh --keepalive-time 2
	# bash Psi4conda-1.4rc3-py38-Linux-x86_64.sh -b -u -p $(HOME)/psi4conda
	# echo '. $(HOME)/psi4conda/etc/profile.d/conda.sh' >> ~/.bashrc
	# echo '$(HOME)/psi4conda/bin/conda activate' >> ~/.bashrc
	# . $(HOME)/psi4conda/etc/profile.d/conda.sh
	# $(HOME)/psi4conda/bin/conda init bash
	# $(HOME)/psi4conda/bin/conda activate
	bash
install-python-dependencies:
	poetry install

build:
	poetry run psi4 --test
	poetry run jupyter-book build ./qmlcourseRU