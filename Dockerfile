FROM python:3.8-slim

WORKDIR /app

COPY . .

RUN pip install Flask

EXPOSE 5000

CMD ["python3", "welcome.py"]

