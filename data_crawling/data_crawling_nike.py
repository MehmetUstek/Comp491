import requests
from selenium import webdriver
from time import sleep

from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import numpy as np

name_list = []
image_list = []
price_list = []

sleep_time = 3
def write_to_csv(filename, name_list, image_list, price_list):
    stack = np.stack((name_list, image_list, price_list), axis=1)
    print(stack)
    np.savetxt(filename, stack, delimiter=",", fmt="%s")


# Crawling part
driver = webdriver.Chrome()
driver.set_window_size(700, 1080)

# SneaksUp
# # Start the process, wait for website to load.
driver.get("https://www.nike.com/w/mens-shoes-nik1zy7ok")
sleep(sleep_time)

# images = driver.find_elements_by_xpath('//*[@id="Wall"]/div/div/div/main/section/div/div/div/figure/a/div/div/img')
names = driver.find_elements_by_css_selector('div.product-card__titles')
prices = driver.find_elements_by_xpath('//*[@id="Wall"]/div/div/div/main/section/div/div/div/figure/div/div/div/div/div/div[1]')

for name in names:
    text = name.text
    print(text)
    name_list.append(text)
for price in prices:
    text = price.text
    print(text)
    price_list.append(text)
index = 0
for name in names:
    # For scrolling down.
    body = driver.find_element_by_css_selector('body')
    for _ in range(2):
        body.send_keys(Keys.PAGE_DOWN)
        sleep(1)
    sleep(sleep_time-2)
    driver.find_elements(by=By.XPATH, value='//*[@id="Wall"]/div/div/div/main/section/div/div/div/figure/a[2]')[index].click()
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
write_to_csv("data.csv", name_list, image_list, price_list)







