"""
pip install flask flask_cors flask_compress
"""

import json
import io
from pathlib import Path

from flask import Flask, request, send_file
from flask_cors import CORS
from flask_compress import Compress
from PIL import Image
import numpy as np


# configuration
DEBUG = True


# instantiate the app
app = Flask(__name__)
app.config["SEND_FILE_MAX_AGE_DEFAULT"] = 0
Compress(app)
app.config.from_object(__name__)

# enable CORS
CORS(app, resources={r"/api/*": {"origins": "*"}})


def parseInt(x):
    try:
        x = int(x)
    except:
        x = None
    return x


def resize(img, h=None, w=None):
    h = parseInt(h)
    w = parseInt(w)
    if h is None and w is None:
        return img

    if h is None:
        if w > img.width:
            return img
        h = int(img.height / img.width * w)

    if w is None:
        if h > img.height:
            return img
        w = int(img.width / img.height * h)

    img = img.resize((w, h))
    return img


@app.route("/api/i/<dataset>/", methods=["GET"], defaults={'_id': None})
@app.route("/api/i/<dataset>/<_id>", methods=["GET"])
def get_image(dataset, _id):
    height = request.args.get("h")
    width = request.args.get("w")
    try:
        instance = get_instance(dataset)
    except:
        instance = None

    if instance is None:
        return "dataset not found"
    else:
        img = instance.image(_id)
        if img is None:
            return "key not found"
        elif 'PIL' in str(type(img)):
            img = img
        elif type(img) is np.ndarray:
            img = Image.fromarray(img)
        else:
            return "not supported yet"

    img = resize(img, height, width)
    file_obj = io.BytesIO()
    img.save(file_obj, format="PNG")
    file_obj.seek(0)
    return send_file(file_obj, mimetype="image/PNG")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=9000)
