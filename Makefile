install: install-python-poetry install-python-dependencies

install-python:
	apt update
	apt install curl python3.8 -y
	update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
	apt install python3-distutils python3-apt
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
	source $HOME/.poetry/env

install-python-dependencies:
	poetry install

build:
	poetry run jupyter-book build ./qmlcourseRU