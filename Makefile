export PATH := $(HOME)/.poetry/bin:$(PATH)

install-ubuntu-latest: install-python-poetry-ubuntu install-python-dependencies
install-macOS-latest: install-python-poetry-macOS install-python-dependencies

install-python-poetry-ubuntu:
	sudo apt update
	sudo apt install curl python3.8 -y
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
	sudo apt install python3-distutils python3-apt -y
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

install-python-poetry-macOS:
	brew update
	brew uninstall --ignore-dependencies python3 pipx
	brew install curl python@3.8 pipx
	python3 -V
	pipx install poetry

install-python-dependencies:
	poetry install

build:
	poetry run jupyter-book build ./qmlcourseRU