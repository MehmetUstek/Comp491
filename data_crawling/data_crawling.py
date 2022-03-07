from selenium import webdriver
from time import sleep
from selenium.webdriver.common.keys import Keys
import numpy as np

name_list = []
image_list = []


def write_to_csv(filename, name_list, image_list):
    stack = np.stack((name_list, image_list), axis=1)
    print(stack)
    np.savetxt(filename, stack, delimiter=",", fmt="%s")


# Crawling part
driver = webdriver.Chrome()

# Adidas.com
# # Start the process, wait for website to load.
driver.get("https://www.adidas.com/us/men-athletic_sneakers")
sleep(10)

images = driver.find_elements_by_xpath('//*[@id="app"]/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/a/img')
names = driver.find_elements_by_xpath('//*[@id="app"]/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/a/div/p')
price = driver.find_elements_by_xpath('//*[@id="app"]/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/div/a/div/div/div[1]')

for name in names:
    text = name.text
    print(text)
    name_list.append(text)

index = 0
for image in images:
    # with open(name_list[index] + ".png", "w+") as file:
    #     file.write(image.screenshot_as_png)
    # src = image.get_attribute('src')
    # print(src)
    # image_list.append(src)
    image_name = "images/image" + str(index) + ".png"
    with open(image_name, "wb") as fh:
        fh.write(image.screenshot_as_png)
    image_list.append(image_name)

    index += 1

# i = 0
# for image in images:
#     src = image.get_attribute('src')
#     urllib.request(src, name_list[i])
#     i += 1


# For scrolling down.
# body = driver.find_element_by_css_selector('body')
# for index in range(13):
#     print(index)
#     body.send_keys(Keys.PAGE_DOWN)
#     sleep(1)

driver.close()

# Put it into csv:
write_to_csv("data.csv", name_list, image_list)

# kullanici_adi_kutusu.send_keys(kullanici_adi)
# giris_yap.click()




