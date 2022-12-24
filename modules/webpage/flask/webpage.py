
from flask import Flask, jsonify, request, render_template, url_for, redirect

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
   return render_template('index.html')

@app.route('/test', methods=['POST', 'GET'])
def test():
   return "Hello, World"

@app.route('/download', methods=['POST', 'GET'])
def download():
   return "Hello, World"

if __name__ == "__main__":
   app.run(host='0.0.0.0')
