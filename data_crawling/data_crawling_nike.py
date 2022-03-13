import requests
from selenium import webdriver
from time import sleep

from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import NoSuchElementException
import numpy as np
import csv


sleep_time = 1


def write_to_csv(filename, name, imageId, price, description):

    with open(filename, 'a', newline='') as fd:
        writer = csv.writer(fd)
        writer.writerow([name,imageId, price, description])


# Crawling part
driver = webdriver.Chrome()
driver.set_window_size(700, 970)


# # Start the process, wait for website to load.
driver.get("https://www.nike.com/w/mens-shoes-nik1zy7ok")

# Initial wait
sleep(sleep_time+ 15)
body = driver.find_element(by=By.CSS_SELECTOR, value='body')
for _ in range(200):
    body.send_keys(Keys.PAGE_DOWN)
    sleep(0.4)

for index in range(553,588):
    # For scrolling down.
    sleep(sleep_time*1.5)

    body = driver.find_element(by=By.CSS_SELECTOR, value='body')
    for _ in range(2):
        body.send_keys(Keys.PAGE_DOWN)
        sleep(0.7)
    sleep(sleep_time)
    driver.find_elements(by=By.XPATH, value='//*[@id="Wall"]/div/div/div/main/section/div/div/div/figure/a[2]')[index].click()
    try:
        temp = driver.find_element(by=By.XPATH, value=
        '//*[@id="PDP"]/div/div[3]/div[1]/div/div[2]/div/div/div/div/div')
        price = temp.text
        description = driver.find_element(by=By.XPATH, value='//*[@id="PDP"]/div/div[3]/div[1]/div/div[2]/div/h2').text
        name = driver.find_element(by=By.XPATH, value=
            '//*[@id="pdp_product_title"]').text

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
        driver.back()
        stack = np.stack((name, imageId, price, description))
        print(stack)
        write_to_csv("data.csv", name, imageId, price, description)
    except NoSuchElementException:
        driver.back()
        continue

driver.close()







