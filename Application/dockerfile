FROM python

COPY . /home/

RUN apt-get update &&\
    pip install -r home/requirements.txt

ENTRYPOINT [ "python3", "/home/run.py" ] 