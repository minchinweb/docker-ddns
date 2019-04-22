FROM minchinweb/python:3.7

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ddns.py ./

CMD [ "python", "./ddns.py" ]
