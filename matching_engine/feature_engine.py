import numpy as np
from tensorflow import keras
from tensorflow.keras.preprocessing.image import load_img
from tensorflow.keras.preprocessing.image import img_to_array
# import the models for further classification experiments
from tensorflow.keras.applications import (
        vgg16,
        resnet50,
        mobilenet,
        inception_v3
    )
import os
import tensorflow as tf
os.environ['CUDA_VISIBLE_DEVICES'] = '-1'


def extract_features_with_vgg16(path):
    layer_name = "fc1"
    model = vgg16.VGG16(weights='imagenet')
    intermediate_layer_model = keras.Model(inputs=model.input, outputs=model.get_layer(layer_name).output)
    model = intermediate_layer_model
    img = load_img(path, target_size = (224, 224))
    numpy_img = img_to_array(img)
    image_batch = np.expand_dims(numpy_img, axis=0)
    processed_image = vgg16.preprocess_input(image_batch.copy())
    return model.predict(processed_image)

