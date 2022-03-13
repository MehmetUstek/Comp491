import pymongo
import dotenv
from bson import json_util
from flask import Flask, jsonify, request, json
from flask_pymongo import PyMongo
from pymongo import MongoClient
from flask_pymongo.wrappers import Database, Collection

# Local
MONGO_URI = 'mongodb://localhost:27017/?readPreference=primary&appname=MongoDB+Compass&directConnection=true&ssl=false'
# Atlas, Remote DB
# MONGO_URI = dotenv.get_key("./.env", "MONGODB_URI")
app = Flask(__name__)
app.config["MONGO_URI"] = MONGO_URI
mongo = PyMongo(app)


def connectToDB():
    client = MongoClient(MONGO_URI)
    db = client['comp491']
    return db


db: Database = connectToDB()
users_collection: Collection = db.get_collection('Users')


@app.route("/user/getUserUIDbyEmail")
def getUserUIDbyEmail():
    pass

def parse_json(data):
    return json.loads(json_util.dumps(data))

@app.route("/user/getUsernameByUID", methods= ['GET'])
def getUsernameByUID():
    userUID = request.get_json()['userUID']
    filter = {
        'userUID': userUID
    }
    user = users_collection.find_one(filter=filter)
    user = parse_json(user)

    return jsonify(user)


if __name__ == '__main__':
    app.run(debug=True, port=9090)