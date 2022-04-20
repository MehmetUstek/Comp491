import json

import numpy as np
from flask_pymongo.wrappers import Collection
import bson
import pickle
from tensorflow.keras.preprocessing.image import load_img

import sys
sys.path.insert(0, "C:/Users/Berkay Akbulut/Desktop/Ders/COMP Bitirme/Comp491/artemis/src/compare")
sys.path.insert(0, "C:/Users/Berkay Akbulut/Desktop/Ders/COMP Bitirme/Comp491/color_histogram")

import image_extraction as ex
import color_histogram as clr
import os
import connection as cn


def read_data():
    data_list = np.genfromtxt("data.csv", delimiter=",", dtype='U')
    return data_list

def get_names():
    return [img for img in os.listdir("./sub1_out")]

def put_to_db(collection: Collection, data_list):
    db_list = []
    img_names = get_names()
    for i in range(len(data_list)):
        data = data_list[i]
        img = img_names[i]
        img = load_img(f"./sub1_out/{img}", target_size=(1280,660))
        vector = ex.extract_resnet(img)
        colour, perc = clr.get_image_color_features(img)
        print(i)
        image_str = data[1]
        image_id = image_str[7:]
        price_with_dollars = data[2]
        price = price_with_dollars[1:]
        db_list.append({
            "Pid": "image" + image_id + "sub1",
            "Pname" : data[0],
            "Pprice" : price,
            "Pdescription": data[3],
            "vgg16": bson.binary.Binary(pickle.dumps(vector)),
            "color": bson.binary.Binary(pickle.dumps(colour)),
            "percentage": bson.binary.Binary(pickle.dumps(perc))
        })
    collection.insert_many(db_list)



def read_product_data_and_put_to_db():
    data_list = read_data()
    db = cn.connectToDB()
    products_collection: Collection = db.get_collection('Products')
    put_to_db(products_collection, data_list)

read_product_data_and_put_to_db()
