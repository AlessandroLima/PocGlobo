from flask import Flask, request
import json

app = Flask(__name__)

@app.route("/", methods=["POST"])
def send_event():
    if request.method == "POST":
        print(str(request.get_json()))
    return json.dumps({'success':True}), 200, {'ContentType':'application/json'} 

if __name__ == "__main__":
    app.run(debug=True, port=5000)