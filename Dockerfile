FROM python:3.8-slim

WORKDIR /app

COPY requirements.txt welcome.py ./

RUN pip install -r requirements.txt


EXPOSE 5000

CMD ["python3", "welcome.py"]

