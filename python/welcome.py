from flask import Flask, request
import platform

app = Flask(__name__)

@app.route('/')
def index():
    return "Welcome to 2022<br>User Agent: " + request.headers.get('User-Agent')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

