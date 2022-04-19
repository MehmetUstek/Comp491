import base64

from flask_pymongo.wrappers import Collection
import pickle
import connection as cn
from flask import json
from bson import json_util
import sys
sys.path.insert(0, "C:/Users/Berkay Akbulut/Desktop/Ders/COMP Bitirme/Comp491/artemis/src/compare")
sys.path.insert(0, "C:/Users/Berkay Akbulut/Desktop/Ders/COMP Bitirme/Comp491/color_histogram")

import image_extraction as ex
import color_histogram as clr
from tensorflow.keras.preprocessing.image import load_img
import numpy as np


def parse_json(data):
    return json.loads(json_util.dumps(data))

def getProductsIDWithResnetVector():
    db = cn.connectToDB()
    arr = []
    products_collection: Collection = db.get_collection('Products')
    products = products_collection.find()
    for prod in products:
        product = parse_json(prod)
        arr.append((product['Pid'], pickle.loads(base64.decodebytes((product['vgg16']["$binary"])['base64'].encode()))))

    return arr

def getProductsIDWithColorandPercVectors():
    db = cn.connectToDB()
    arr = []
    products_collection: Collection = db.get_collection('Products')
    products = products_collection.find()
    for prod in products:
        product = parse_json(prod)
        arr.append((product['Pid'], pickle.loads(base64.decodebytes((product['color']["$binary"])['base64'].encode())),
                    pickle.loads(base64.decodebytes((product['percentage']["$binary"])['base64'].encode()))))

    return arr

def getResNetScores():
    scores = []
    #res = ex.extract_resnet(img)
    all_res = getProductsIDWithResnetVector()
    for i in range(20):
        score = ex.compare(all_res[0][1], all_res[i+1][1])
        scores.append((all_res[i+1][0], score))
    return scores

def getColorScores():
    scores = []
    #colr, perc = clr.get_image_color_features(img)
    all_clr = getProductsIDWithColorandPercVectors()
    for i in range(20):
        score = clr.find_similiarity_score(all_clr[0][1], all_clr[0][2], all_clr[i+1][1], all_clr[i+1][2])
        scores.append((all_clr[i+1][0], -score))
    return scores

def normalize_arrays_and_weighted_avg(vector1, vector2):
    ans = []
    vec1_arr = []
    vec2_arr = []
    for i in range(len(vector1)):
        vec1_arr.append(vector1[i][1])
        vec2_arr.append(vector2[i][1])

    m1 = np.mean(np.array(vec1_arr))
    std1 = np.std(np.array(vec1_arr))
    m2 = np.mean(np.array(vec2_arr))
    std2 = np.std(np.array(vec2_arr))

    for j in range(len(vector1)):
        ans.append((vector1[j][0], ((vector1[j][1] - m1)/std1)*0.5 + ((vector2[j][1] - m2)/std2)*0.5))

    return ans

def get_k_min(nparray, k):
    return np.sort(
        nparray[nparray[:,1].argpartition(k, axis = 0)[0:k],:].view('i8,i8'),
        order = ['f1'], axis = 0)


def best_ones_ids():
    resnet_scores = getResNetScores()
    color_scores = getColorScores()
    arr = normalize_arrays_and_weighted_avg(resnet_scores, color_scores)
    return arr








