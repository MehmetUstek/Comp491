from tensorflow.keras.preprocessing.image import load_img
import unittest
from src.compare import image_extraction as ie


class TestImageExtractors(unittest.TestCase):

    def test_l2_with_resnet(self):
        img1 = load_img(
            "/home/serhat/Documents/github/Comp491/artemis/tests/shoe1.png", target_size=(224, 224))
        feature = ie.extract_resnet(img1)
        self.assertTrue(ie.compare(feature, feature, type="l2") == 0)
