import numpy as np
from flask_pymongo.wrappers import Collection

import connection as cn


def read_data():
    data_list = np.genfromtxt("data.csv", delimiter=",", dtype='U')
    return data_list

def put_to_db(collection: Collection, data_list):
    db_list = []
    for data in data_list:
        image_str = data[1]
        image_id = image_str[-1:]
        price_with_dollars = data[2]
        price = price_with_dollars[1:]
        db_list.append({
            "Pname" : data[0],
            "PimageId": image_id,
            "Pprice" : price,
            "Pdescription": data[3],
            "Pimages":
                {
                    "image1": "image" + image_id + "sub1",
                    "image2": "image" + image_id + "sub2",
                    "image3": "image" + image_id + "sub3",
                    "image4": "image" + image_id + "sub4"
                }

        })
    collection.insert_many(db_list)



def read_product_data_and_put_to_db():
    data_list = read_data()
    db = cn.connectToDB()
    products_collection: Collection = db.get_collection('Products')
    put_to_db(products_collection, data_list)

read_product_data_and_put_to_db()
