import pymongo
#import dotenv
from bson import json_util, objectid
from flask import Flask, jsonify, request, json, Response
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
    try:
        client = MongoClient(MONGO_URI)
        db = client['comp491']
        client.server_info() #trigger exception
        return db
    except:
        print("ERROR - Cannot connect to the database")




db: Database = connectToDB()
users_collection: Collection = db.get_collection('Users')


@app.route("/user/getUserUIDbyEmail")
def getUserUIDbyEmail():
    pass

def parse_json(data):
    return json.loads(json_util.dumps(data))

@app.route("/user/getUserByUID", methods= ['GET', 'POST'])
def getUserByUID():
    try:
        userUID = request.get_json()['userUID']
        filter = {
            'userUID': userUID
        }
        user = users_collection.find_one(filter=filter)
        # if(user is None):
        #     return parse_json({"": ""})
        user = parse_json(user)

        return user
    except Exception as ex:
        print(ex)


@app.route("/user/getUsernameByUID", methods= ['GET', 'POST'])
def getUsernameByUID():
    userUID = request.get_json()['userUID']
    filter = {
        'userUID': userUID
    }
    user = users_collection.find_one(filter=filter)

    user = parse_json(user)
    username = user['username']

    return username

@app.route("/user/getUserEmailByUID", methods= ['GET', 'POST'])
def getUserEmailByUID():
    userUID = request.get_json()['userUID']
    filter = {
        'userUID': userUID
    }
    user = users_collection.find_one(filter=filter)

    user = parse_json(user)
    userEmail = user['userEmail']

    return userEmail

@app.route("/user/changeUsernameByUserId", methods= ['PATCH'])
def changeUsernameByUserID():
    try:
        uID = request.get_json()['userID']
        users_collection.update_one(
            {"userUID": uID},
            {"$set":{"username":request.form["username"]}}
        )
        return Response(
            response= json.dumps(
                {"message":"username updated"}),
            status=200,
            mimetype='applicaiton/json'
            )
    except Exception as ex:
        print(ex)
        return Response(
            response= json.dumps(
                {"message":"Cannot update username"}),
            status=500,
            mimetype='application/json'
        )









if __name__ == '__main__':
    app.run(debug=True, port=9090)
