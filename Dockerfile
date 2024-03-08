FROM python:3.8-slim

WORKDIR /app

COPY ./welcome.py ./requirements.txt ./

RUN pip install Flask

EXPOSE 5000

CMD ["python3", "welcome.py"]

