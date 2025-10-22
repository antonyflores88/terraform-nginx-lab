import redis
from flask import Flask, Response, jsonify
import os

app = Flask(__name__)

#Getting environment variables
ENVIRONMENT = os.getenv('ENVIRONMENT', 'dev')
REDIS_HOST = os.getenv("REDIS_HOST",'localhost')

@app.route('/check')
def check_connections():
    status = {"env": ENVIRONMENT}
    # Redis check
    try:
        r = redis.Redis(host=REDIS_HOST, port=6379, socket_connect_timeout=3)
        pong = r.ping()
        status["redis_host"] = REDIS_HOST
        status["redis_status"] = "ok" if pong else "no-pong"
    except Exception as e:
        status["redis_status"] = f"error: {e.__class__.__name__}"
    return jsonify(status), 200

@app.route('/env')
def get_environment():
    return f"Current Environment: {ENVIRONMENT}", 200
@app.route('/')
def home():
    html = f"""
    <html>
        <head>
            <title>Tony Cloud Lab ({ENVIRONMENT})</title>
        </head>
        <body style="background-color: #1F778D">
            <p style="text-align: center;">
                <span style="color:#FFFFFF;">
                    <span style="font-size:100px;">
                        🚀🚀Welcome to Tony Cloud Lab Server<br>({ENVIRONMENT} Environment)
                    </span>
                </span>
            </p>
        </body>
    </html>
    WEBSITE
    """
    return Response(html, mimetype='text/html')

@app.route('/healthz')
def health_check():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
