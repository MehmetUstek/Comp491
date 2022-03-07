import requests
from selenium import webdriver
from time import sleep

from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import numpy as np

image_list = []
driver = webdriver.Chrome()
driver.get("https://www.nike.com/t/air-zoom-pegasus-38-mens-road-running-shoes-lq7PZZ/CW7356-700")
sleep(5)
# //*[@id="PDP"]/div/div[3]/div[2]/div[1]/div/div/ul/li[3]/span/button/div/picture[2]/img
for image_index in range(1,5):
    # //*[@id="PDP"]/div/div[3]/div[2]/div[1]/div/div/ul/li/span/button/div/picture[2]/source[1]
    # //*[@id="PDP"]/div/div[3]/div[2]/div[1]/div/div/ul/li/span/button/div/picture[2]/img
    # '//*[@id="PDP"]/div/div[3]/div[2]/div[1]/div/div/ul/li[1]/span/button/div/picture[2]/img'
    # //*[@id="PDP"]/div/div[3]/div[2]/div[1]/div/div/ul/li[2]/span/button/div/picture[2]/img
    value = '//*[@id="PDP"]/div/div[3]/div[2]/div[1]/div/div/ul/li['+str(image_index) +']/span/button/div/picture[2]/img'
    image = driver.find_element(by=By.XPATH,
                        value=value)
    src = image.get_attribute('src')
    response = requests.get(src)
    image_name = "images/image" + str(image_index) + ".png"
    file = open(image_name, "wb")
    file.write(response.content)
    file.close()
