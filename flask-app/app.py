from flask import Flask, Response
app = Flask(__name__)

@app.route('/')
def home():
    html = """
    <html>
        <head>
            <title>Tony Cloud Lab Server</title>
        </head>
        <body style="background-color: #1F778D">
            <p style="text-align: center;">
                <span style="color:#FFFFFF;">
                    <span style="font-size:100px;">Welcome to Tony Cloud Lab Server</span>
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
