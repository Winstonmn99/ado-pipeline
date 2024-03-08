FROM python:3.8-slim

WORKDIR /app

COPY welcome.py ./

RUN pip install Flask

EXPOSE 5000

CMD ["python3", "welcome.py"]

