import cv2
import os
from PIL import Image

for imgName in os.listdir("./sub1_out/"):
    h = 750
    w = 1244
    x = 42
    y = 450
    img = cv2.imread("./sub1_out/"+ imgName)
    crop_img = img[y:y+h, x:x+w]
    # img_half = cv2.resize(crop_img, (0, 0), fx=0.2, fy=0.2)
    print(crop_img.shape)
    cv2.imshow("cropped", crop_img)

    cv2.waitKey(0)
    cv2.imwrite("./croppedImages/imgName", img_half)