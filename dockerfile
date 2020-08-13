FROM python

COPY . /home/

RUN apt-get update &&\
    pip install -r home/requirements.txt &&\
    python3 /home/run.py 