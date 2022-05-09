#!/usr/bin/env python
# coding: utf-8


# Implements image related feature extraction functions
# Provides utility to compare feature vectors


# imports

# tensorflow realted libraries
from tensorflow import keras
from tensorflow.keras.preprocessing.image import load_img
from tensorflow.keras.preprocessing.image import img_to_array
from tensorflow.keras.applications.imagenet_utils import decode_predictions

# standart data analysis libraries
import matplotlib.pyplot as plt
import numpy as np

# defines cosine distance
from scipy import spatial

# pretrained models
from tensorflow.keras.applications import (
    vgg16,
    resnet50,
    mobilenet,
    inception_v3
)
from keras.utils import np_utils
from keras.models import Model, Sequential, load_model
from keras.layers import Dense, Conv2D, MaxPooling2D, Flatten, Reshape, Dropout


import os
os.environ['CUDA_VISIBLE_DEVICES'] = '-1'
"""
  Globals
"""

methods = dict()

# Init vgg16, load imagenet pretrained weights
vgg16_model = vgg16.VGG16(weights='imagenet', include_top=False)
# Init resnet50
resnet50_model = resnet50.ResNet50(weights='imagenet', include_top=False)


def as_extractor(method_name):
    def decorator(func):
        methods[method_name] = func
        return func

    return decorator


# TODO Implement normalization routin
def compare(feature1, feature2, type="cosine"):
    """ Returns a similarity measure, note that it is not normalized

    Parameters
    ----------
    feature1: list<number>, feature vector
    feature2: list<number>, feature vector
    type:     string, l1, l2, or cosine similarity measure
    Raises
    ------
    ValueError
        If 2 feature vectors are not of same length
    """
    if len(feature1) != len(feature2):
        raise ValueError("Features are not of same length!")

    if type == "l1":
        return np.linalg.norm(feature1 - feature2, ord=1)

    if type == "l2":
        return np.linalg.norm(feature1 - feature2)
    return 1 - spatial.distance.cosine(feature1.flatten(), feature2.flatten())


@as_extractor("vgg16")
def extract_vgg16(img):
    """ Returns feature vector, extracted using vgg16

    Parameters
    ----------
    img: PIL format image

    """
    # Prepare image as an input
    numpy_img = img_to_array(img)
    image_batch = np.expand_dims(numpy_img, axis=0)

    # preprocess the img, based on pre-trained model's procedure
    # Need to research how to make this part programatic
    processed_image = vgg16.preprocess_input(image_batch.copy())
    feature_vector = vgg16_model.predict(processed_image)
    return feature_vector.flatten()


@as_extractor("resnet50")
def extract_resnet(img):
    """ Returns feature vector, extracted using resnet5*

    Parameters
    ----------
    img: PIL format image

    """
    # Prepare image as an input
    numpy_img = img[:, :, :3]
    image_batch = np.expand_dims(numpy_img, axis=0)

    # preprocess the img, based on pre-trained model's procedure
    # Need to research how to make this part programatic
    processed_image = resnet50.preprocess_input(image_batch.copy())
    feature_vector = resnet50_model.predict(processed_image)
    return feature_vector


def extract(img, extractors=None):
    """Returns an dictionary of vectors, where keys are feature type and values are feature vectors

    If argument methods is not passed, all is assumed. 'all' implies every avaliable method will be
    used to return feature vectors.    

    Parameters
    ----------
    img: PIL format image
    extractors: tuple of methods to cretae feature vectors

    """
    if extractors is None:
        extractors = ["all"]
    features = dict()

    if "all" in extractors:
        for name, extractor in methods:
            features[name] = extractor(img)
        return features

    for name in extractors:
        features[name] = methods[name](img)
    return features


""" If needed for future reference

layer_name = "fc1"
model = vgg16.VGG16(weights='imagenet')
intermediate_layer_model = keras.Model(
    inputs=model.input, outputs=model.get_layer(layer_name).output)
model = intermediate_layer_model
model.summary()
# load img
img1 = load_img('./img1.jpg', target_size=(224, 224))
img2 = load_img('./img2.jpg', target_size=(224, 224))

numpy_img = img_to_array(img1)
image_batch = np.expand_dims(numpy_img, axis=0)
processed_image1 = vgg16.preprocess_input(image_batch.copy())

numpy_img = img_to_array(img2)
image_batch = np.expand_dims(numpy_img, axis=0)
processed_image2 = vgg16.preprocess_input(image_batch.copy())

p2 = model.predict(processed_image2)
p1 = model.predict(processed_image1)
"""
