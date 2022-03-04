#!/usr/bin/env python
# coding: utf-8


# Implements image related feature extraction functions
# Provides utility to compare feature vectors


#imports

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






def compare(feature1, feature2):
    """ Returns cosine similarity between feature vectors
    
    Parameters
    ----------
    feature1: list<number>, feature vector
    feature2: list<number>, feature vector
    
    Raises
    ------
    ValueError
        If 2 feature vectors are not of same length
    """
    if len(feature1) != len(feature2):
        raise ValueError("Features are not of same length!")
    
    return 1 - spatial.distance.cosine(feature1, feature2) 



def extract(image, methods=list("all")):
    """ Returns an dictionary of vectors, where keys are feature type and values are feature vectors
    
    If argument methods is not passed, all is assumed. 'all' implies every avaliable method will be 
    used to return feature vectors.
    
    Parameters
    ----------
    
    
    """

def init_model(self, model_name):
    
    if model_name == "resnet":
        pass
    
    if model_name == "vggnet":
        from tensorflow.keras.applications import (vgg16)
        layer_name = "fc1"
        model = vgg16.VGG16(weights='imagenet')
        intermediate_layer_model = keras.Model(inputs=model.input, outputs=model.get_layer(layer_name).output)

            
    
# Returns the features for image in the filename
def get_features(self, filename):
    
    ### Note that target size is model specific
    # I am dirty coding for fast prototyping
    img = load_img(filename, target_size = (224, 224))
    numpy_img = img_to_array(img)
    image_batch = np.expand_dims(numpy_img, axis=0)
    
    # preprocess the img, based on pre-trained model's procedure
    # Need to research how to make this part programatic
    processed_image = vgg16.preprocess_input(image_batch.copy())
    predictions = model.predict(processed_image)
    return predictions
    


layer_name = "fc1"
model = vgg16.VGG16(weights='imagenet')
intermediate_layer_model = keras.Model(inputs=model.input, outputs=model.get_layer(layer_name).output) 
model = intermediate_layer_model
model.summary()
# load img
img1 = load_img('./img1.jpg', target_size = (224, 224))
img2 = load_img('./img2.jpg', target_size = (224, 224))

numpy_img = img_to_array(img1)
image_batch = np.expand_dims(numpy_img, axis=0)
processed_image1 = vgg16.preprocess_input(image_batch.copy())

numpy_img = img_to_array(img2)
image_batch = np.expand_dims(numpy_img, axis=0)
processed_image2 = vgg16.preprocess_input(image_batch.copy())

p2 = model.predict(processed_image2)
p1 = model.predict(processed_image1)
