install-ubuntu-latest: install-python-poetry-ubuntu install-python-dependencies
install-macOS-latest: install-python-poetry-macOS install-python-dependencies

install-python-poetry-ubuntu:
	sudo apt update
	sudo apt install curl python3.8 -y
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
	sudo apt install python3-distutils python3-apt -y
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
	PATH="${HOME}/.poetry/bin:${PATH}"

install-python-poetry-macOS:
	brew update
	brew install curl python@3.8 -y
	brew install python3-distutils python3-apt -y
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
	/bin/bash -c "source ~/.poetry/env"

install-python-dependencies:
	poetry install

build:
	poetry run jupyter-book build ./qmlcourseRU