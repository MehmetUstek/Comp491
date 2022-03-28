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

@app.route("/user/create_user", methods=['POST'])
def create_user():
    try:
        UID = request.json['userUID']
        name = request.json['username']
        mail = request.json['userEmail']

        users_collection.insert_one(
            {'userUID':UID, 'username':name, 'userEmail':mail}
        )
        return Response(
            response=json.dumps(
                {"message": "user inserted"}),
            status=200,
            mimetype='applicaiton/json'
        )
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "user not inserted. Please indicate "
                            "userUID, username and userEmail"}),
            status=500,
            mimetype='applicaiton/json'
        )

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
        return Response(
            response=json.dumps(
                {"message": "cannot retrieve user"}),
            status=500,
            mimetype='applicaiton/json'
        )


@app.route("/user/getUsernameByUID", methods= ['GET', 'POST'])
def getUsernameByUID():
    try:
        userUID = request.get_json()['userUID']
        filter = {
            'userUID': userUID
        }
        user = users_collection.find_one(filter=filter)

        user = parse_json(user)
        username = user['username']

        return username
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve the username"}),
            status=500,
            mimetype='application/json'
        )

@app.route("/user/getUserEmailByUID", methods= ['GET', 'POST'])
def getUserEmailByUID():
    try:
        userUID = request.get_json()['userUID']
        filter = {
            'userUID': userUID
        }
        user = users_collection.find_one(filter=filter)

        user = parse_json(user)
        userEmail = user['userEmail']

        return userEmail
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve email"}),
            status=500,
            mimetype='application/json'
        )

@app.route("/user/changeUsernameByUID", methods= ['PATCH'])
def changeUsernameByUID():
    try:
        uID = request.get_json()['userUID']
        filter = {
            'userUID': uID
        }
        username = request.json["username"]
        users_collection.update_one(
            filter,
            {"$set": {"username": username}}
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
                {"message":"Cannot update username, please indicate UID and new username"}),
            status=500,
            mimetype='application/json'
        )



if __name__ == '__main__':
    app.run(debug=True, port=9090)
