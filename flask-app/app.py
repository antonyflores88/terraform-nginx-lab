from flask import Flask, Response
import os

app = Flask(__name__)

#Getting environment variables
ENVIRONMENT = os.getenv('ENVIRONMENT', 'dev')
DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
REDIS_HOST = os.getenv("REDIS_HOST")

@app.route('/check')
def check_connections():
    return jsonify({
        "env": ENVIRONMENT,
        "db_host": DB_HOST,
        "redis_host": REDIS_HOST
    }), 200

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
                        Welcome to Tony Cloud Lab Server<br>({ENVIRONMENT} Environment)
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
