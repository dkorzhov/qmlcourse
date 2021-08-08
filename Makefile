install: install-python-poetry install-python-dependencies

install-python:
	apt update
	apt install curl python3.8 -y
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -

install-python-dependencies:
	poetry install

build:
	poetry run jupyter-book build ./qmlcourseRU