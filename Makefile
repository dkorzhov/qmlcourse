install: install-python-poetry install-python-dependencies

install-python:
	sudo apt update
	sudo apt install curl python3.8 -y
	sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

install-python-dependencies:
	poetry install

build:
	poetry run jupyter-book build ./qmlcourseRU