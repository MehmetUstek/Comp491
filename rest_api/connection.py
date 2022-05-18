import pymongo
import dotenv
from bson import json_util, objectid
from flask import Flask, jsonify, request, json, Response
from flask_pymongo import PyMongo
from pymongo import MongoClient
from flask_pymongo.wrappers import Database, Collection
import pickle
#import data_usage as dat
from rest_api.data_usage import best_ones_ids
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
products_collection: Collection = db.get_collection('Products')
bags_collection: Collection = db.get_collection("Bags")


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
            mimetype='application/json'
        )
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "user not inserted. Please indicate "
                            "userUID, username and userEmail"}),
            status=500,
            mimetype='application/json'
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
            mimetype='application/json'
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
            mimetype='application/json'
            )
    except Exception as ex:
        print(ex)
        return Response(
            response= json.dumps(
                {"message":"Cannot update username, please indicate UID and new username"}),
            status=500,
            mimetype='application/json'
        )

@app.route("/product/getAllProducts", methods= ['GET', 'POST'])
def getAllProducts():
    try:
        products = products_collection.find()
        product_list = parse_json(products[:100])
        return jsonify(product_list)
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve the username"}),
            status=500,
            mimetype='application/json'
        )
@app.route("/product/getProductByPid", methods= ['GET', 'POST'])
def getProductByPid():
    try:
        Pid = request.get_json()['Pid']
        filter = {
            'Pid': Pid
        }
        products = products_collection.find_one(filter=filter)
        product = parse_json(products)
        return product
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve the username"}),
            status=500,
            mimetype='application/json'
        )

@app.route("/product/getProductNameByPid", methods= ['GET', 'POST'])
def getProductNameByPid():
    try:
        Pid = request.get_json()['Pid']
        filter = {
            'Pid': Pid
        }
        products = products_collection.find_one(filter=filter)
        product = parse_json(products)['Pname']
        return product
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve the username"}),
            status=500,
            mimetype='application/json'
        )

 # BAG
@app.route("/bag/addToUserBagByUserUIDandPid", methods=['PUT'])
def addToUserBagByUserUIDandPid():
    try:
        userUID = request.get_json()['userUID']
        Pid = request.get_json()['Pid']
        filter = {
            'userUID': userUID
        }
        bags_collection.update_one(filter=filter, update={'$push': {"ProductIds": Pid}}, upsert=True)
        return Response(
            response=json.dumps(
                {"message": "user updated bag"}),
            status=200,
            mimetype='application/json'
        )
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve the username"}),
            status=500,
            mimetype='application/json'
        )

@app.route("/bag/deleteProductFromUserBagByUserUIDandPid", methods=['PUT'])
def deleteProductFromUserBagByUserUIDandPid():
    try:
        userUID = request.get_json()['userUID']
        Pid = request.get_json()['Pid']
        filter = {
            'userUID': userUID
        }
        bags_collection.update_one(filter=filter, update={'$pull': {"ProductIds": Pid}})
        return Response(
            response=json.dumps(
                {"message": "user updated bag"}),
            status=200,
            mimetype='application/json'
        )
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve the username"}),
            status=500,
            mimetype='application/json'
        )


@app.route("/bag/getUserBagByUserUID", methods= ['GET', 'POST'])
def getUserBagByUserUID():
    try:
        userUID = request.get_json()['userUID']
        filter = {
            'userUID': userUID
        }
        bag = bags_collection.find_one(filter=filter)
        products = bag["ProductIds"]
        product_list = []
        for productId in products:
            product_filter = {
                "Pid" : productId
            }
            product_list.append(products_collection.find_one(filter=product_filter))
        product_list = parse_json(product_list)
        return jsonify(product_list)
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve the username"}),
            status=500,
            mimetype='application/json'
        )

@app.route("/bag/getUserBagItemsByUserUID", methods= ['GET', 'POST'])
def getUserBagItemsByUserUID():
    try:
        userUID = request.get_json()['userUID']
        filter = {
            'userUID': userUID
        }
        bag = bags_collection.find_one(filter=filter)
        products = bag["ProductIds"]
        return jsonify(products)
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve the username"}),
            status=500,
            mimetype='application/json'
        )

@app.route("/product/getSuggestedProductsByPid", methods= ['GET', 'POST'])
def getSuggestedProductsByPid():
    try:
        Pid = int(request.get_json()['Pid'])

        #####
        ##TODO: Do the ML operation and return new products that are similar.

        ######
        lst = best_ones_ids(Pid)

        filter = {
            'Pid': {"$in": lst}
        }

        products = products_collection.find(filter=filter)
        product_list = parse_json(products)
        return jsonify(product_list)
    except Exception as ex:
        print(ex)
        return Response(
            response=json.dumps(
                {"message": "Cannot retrieve the username"}),
            status=500,
            mimetype='application/json'
        )

def addPimagesToDB():
    products = products_collection.find(projection={'resnet50':False, 'color':False, 'percentage':False,'_id':False})
    product_list = parse_json(products)
    index = 0
    for product in product_list:
        # Update Pimages
        products_collection.update_one(filter={"Pid": product['Pid']}, update={'$set': {
            "Pimages": {
                "image1": "image"+product['Pid']+"sub1",
                "image2": "image" + product['Pid'] + "sub2",
                "image3": "image" + product['Pid'] + "sub3",
                "image4": "image" + product['Pid'] + "sub4",

            }
        }})
        # Update Pids from string to int.
        products_collection.update_one(filter={"Pid":product['Pid']}, update={'$set': {
            "Pid": int(product['Pid'])
        }})
        print(index)
        index += 1

# addPimagesToDB()


if __name__ == '__main__':
    app.run(debug=True, port=9090, host='0.0.0.0')
