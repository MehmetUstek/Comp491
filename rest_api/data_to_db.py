import json

import numpy as np
from flask_pymongo.wrappers import Collection
import bson
import pickle

import sys
sys.path.insert(0, "C:/Users/Berkay Akbulut/Desktop/Ders/COMP Bitirme/Comp491/matching_engine")
import os

import feature_engine as eng
import os
import connection as cn


def read_data():
    data_list = np.genfromtxt("data.csv", delimiter=",", dtype='U')
    return data_list

def get_names():
    return [img for img in os.listdir("./sub1")]

def put_to_db(collection: Collection, data_list):
    db_list = []
    img_names = get_names()
    for i in range(len(data_list)):
        data = data_list[i]
        img = img_names[i]
        print(i)
        vector = eng.extract_features_with_vgg16(f"./sub1/{img}")
        image_str = data[1]
        image_id = image_str[-1:]
        price_with_dollars = data[2]
        price = price_with_dollars[1:]
        db_list.append({
            "Pname" : data[0],
            "PimageId": image_id,
            "Pprice" : price,
            "Pdescription": data[3],
            "Pimage_vectors":
                {
                    "image" + image_id + "sub1": {"vgg16": pickle.dumps(vector, protocol=2), "resnet" : "boş"},
                    "image" + image_id + "sub2": "boş",
                    "image" + image_id + "sub3": "boş",
                    "image" + image_id + "sub4": "boş"
                }
        })
    collection.insert_many(db_list)



def read_product_data_and_put_to_db():
    data_list = read_data()
    db = cn.connectToDB()
    products_collection: Collection = db.get_collection('Products')
    put_to_db(products_collection, data_list)

read_product_data_and_put_to_db()
