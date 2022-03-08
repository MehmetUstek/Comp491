import requests
from selenium import webdriver
from time import sleep

from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import numpy as np

name_list = []
image_list = []
price_list = []
description_list = []

sleep_time = 2
def write_to_csv(filename, name_list, image_list, price_list, description_list):
    stack = np.stack((name_list, image_list, price_list,description_list), axis=1)
    print(stack)
    np.savetxt(filename, stack, delimiter=",", fmt="%s")


# Crawling part
driver = webdriver.Chrome()
driver.set_window_size(700, 1080)

# # Start the process, wait for website to load.
driver.get("https://www.nike.com/w/mens-shoes-nik1zy7ok")
# Initial wait
sleep(sleep_time+20)

for index in range(588):
    # For scrolling down.
    body = driver.find_element(by=By.CSS_SELECTOR, value='body')
    for _ in range(2):
        body.send_keys(Keys.PAGE_DOWN)
        sleep(1)
    sleep(sleep_time-2)
    driver.find_elements(by=By.XPATH, value='//*[@id="Wall"]/div/div/div/main/section/div/div/div/figure/a[2]')[index].click()

    price = driver.find_element(by=By.XPATH, value=
        '//*[@id="PDP"]/div/div[3]/div[1]/div/div[2]/div/div/div/div/div').text
    price_list.append(price)
    description = driver.find_element(by=By.XPATH, value='//*[@id="PDP"]/div/div[3]/div[1]/div/div[2]/div/h2').text
    description_list.append(description)
    name = driver.find_element(by=By.XPATH, value=
        '//*[@id="pdp_product_title"]').text
    name_list.append(name)

    sleep(sleep_time)
    for image_index in range(1, 5):
        value = '//*[@id="PDP"]/div/div[3]/div[2]/div[1]/div/div/ul/li[' + str(
            image_index) + ']/span/button/div/picture[2]/img'
        image = driver.find_element(by=By.XPATH,
                                    value=value)
        src = image.get_attribute('src')
        response = requests.get(src)
        image_name = "images/image" + str(index) + "sub" + str(image_index) + ".png"
        file = open(image_name, "wb")
        file.write(response.content)
        file.close()
    imageId = "imageId" + str(index)
    image_list.append(imageId)
    driver.back()
    index += 1
    sleep(sleep_time)

    # Mid-way data save
    if (index % 10 == 0):
        write_to_csv("data.csv", name_list, image_list, price_list)




driver.close()

# Put it into csv:
write_to_csv("data.csv", name_list, image_list, price_list, description_list)







