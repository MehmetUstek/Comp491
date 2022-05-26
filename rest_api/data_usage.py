import base64

from flask_pymongo.wrappers import Collection
import pickle
from flask import json
from bson import json_util
from pymongo import MongoClient
import sys
sys.path.insert(0, "../artemis/src/compare")
sys.path.insert(0, "../color_histogram")

import image_extraction as ex
import color_histogram as clr
import numpy as np


MONGO_URI = 'mongodb://localhost:27017/?readPreference=primary&appname=MongoDB+Compass&directConnection=true&ssl=false'
def connectToDB():
    try:
        client = MongoClient(MONGO_URI)
        db = client['comp491']
        client.server_info() #trigger exception
        return db
    except:
        print("ERROR - Cannot connect to the database")

def parse_json(data):
    return json.loads(json_util.dumps(data))

def getProductsIdWithResnetandColorVector():
    db = connectToDB()
    arr1 = []
    arr2 = []
    products_collection: Collection = db.get_collection('Products')
    products = products_collection.find()
    for prod in products:
        product = parse_json(prod)
        arr1.append((product['Pid'], pickle.loads(base64.decodebytes((product['renet50-colorless']["$binary"])['base64'].encode()))))
        arr2.append((product['Pid'], pickle.loads(base64.decodebytes((product['color']["$binary"])['base64'].encode())),
                    pickle.loads(base64.decodebytes((product['percentage']["$binary"])['base64'].encode()))))

    return arr1, arr2

def getResNetandColorScores(id):
    scores1 = []
    scores2 = []
    ind = 0
    all_res, all_clr = getProductsIdWithResnetandColorVector()
    for j in range(len(all_clr)):
        if id == all_clr[j][0]:
            ind = j
            break

    for i in range(len(all_clr)):
        score1 = np.abs(ex.compare(all_res[ind][1], all_res[i][1]))
        score2 = clr.find_similiarity_score(all_clr[ind][1], all_clr[ind][2], all_clr[i][1], all_clr[i][2])
        scores1.append((all_res[i][0], -score1))
        scores2.append((all_clr[i][0], -score2))
    return scores1, scores2

# def getColorScores():
#     scores = []
#     #colr, perc = clr.get_image_color_features(img)
#     all_clr = getProductsIDWithColorandPercVectors()
#     for i in range(20):
#         score = clr.find_similiarity_score(all_clr[0][1], all_clr[0][2], all_clr[i+1][1], all_clr[i+1][2])
#         scores.append((all_clr[i+1][0], -score))
#     return scores

def normalize_arrays_and_weighted_avg(vector1, vector2, w1, w2):
    ans = []
    vec1_arr = []
    vec2_arr = []
    for i in range(len(vector2)):
        vec1_arr.append(vector1[i][1])
        vec2_arr.append(vector2[i][1])

    m1 = np.mean(np.array(vec1_arr))
    std1 = np.std(np.array(vec1_arr))
    m2 = np.mean(np.array(vec2_arr))
    std2 = np.std(np.array(vec2_arr))

    for j in range(len(vector1)):
        ans.append((vector1[j][0], ((vector1[j][1] - m1)/std1)*w1 + ((vector2[j][1] - m2)/std2)*w2))

    return ans

def get_k_min(scores, k):
    proper_form = b = np.array(scores,dtype=[('id', 'int32'), ('distance', 'f8')])
    return np.sort(
        proper_form[proper_form.argpartition(k,order = ['distance'])[0:k]],
        order = ['distance'], axis = 0)

def best_ones_ids(id, weight1, weight2):
    k_min = 10
    res_scores, color_scores = getResNetandColorScores(id)
    arr = normalize_arrays_and_weighted_avg(res_scores, color_scores, weight1, weight2)
    new = get_k_min(arr, k_min)
    ret = []
    for item in new:
        if item[0] != id:
            ret.append(item[0].item())
    return ret

# print(best_ones_ids("60", 0.1, 0.9))










