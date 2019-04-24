FROM minchinweb/python:3.7

COPY requirements.txt ./
# base image should have turned off pip caching
RUN pip install -r requirements.txt

COPY ddns.py ./

CMD [ "python", "./ddns.py" ]
