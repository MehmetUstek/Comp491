import sys
from PIL import Image
import glob
import torch
from torchvision import transforms
from u2net import utils, model
import numpy as np


path_to_load = sys.argv[1]
path_to_save = sys.argv[2]
image_list = []

model_path = 'model/u2net.pth'
model_pred = model.U2NET(3, 1)
model_pred.load_state_dict(torch.load(model_path, map_location="cpu"))
model_pred.eval()

def norm_pred(d):
    ma = torch.max(d)
    mi = torch.min(d)
    dn = (d - mi) / (ma - mi)
    return dn

def preprocess(image):
    label_3 = np.zeros(image.shape)
    label = np.zeros(label_3.shape[0:2])

    if 3 == len(label_3.shape):
        label = label_3[:, :, 0]
    elif 2 == len(label_3.shape):
        label = label_3

    if 3 == len(image.shape) and 2 == len(label.shape):
        label = label[:, :, np.newaxis]
    elif 2 == len(image.shape) and 2 == len(label.shape):
        image = image[:, :, np.newaxis]
        label = label[:, :, np.newaxis]

    transform = transforms.Compose([utils.RescaleT(320), utils.ToTensorLab(flag=0)])
    sample = transform({"imidx": np.array([0]), "image": image, "label": label})

    return sample

def load_images():
    for filename in glob.glob(path_to_load+'/*'): #assuming gif
        im=Image.open(filename)
        name = filename[filename.rfind("/"):]
        image_list.append((im, name))
        

def remove(image):
    sample = preprocess(np.array(image))
    with torch.no_grad():
        inputs_test = torch.FloatTensor(sample["image"].unsqueeze(0).float())
        d1, _, _, _, _, _, _ = model_pred(inputs_test)
        pred = d1[:, 0, :, :]
        predict = norm_pred(pred).squeeze().cpu().detach().numpy()
        img_out = Image.fromarray(predict * 255).convert("RGB")
        image = image.resize((img_out.size), resample=Image.BILINEAR)
        empty_img = Image.new("RGBA", (image.size), 0)
        img_out = Image.composite(image, empty_img, img_out.convert("L"))

    return img_out

def remove_bg(images):
    image_out_list = []
    for (image, name)in images:
        img_out = image.copy()
        for _ in range(5):
            img_out = remove(img_out)

        img_out = img_out.resize(image.size, resample = Image.BILINEAR) 
        empty_image = Image.new("RGBA", image.size, 0)   
        img_out = Image.composite(image, empty_image, img_out)
        image_out_list.append((img_out, name))
        
    return image_out_list

def save_images(images):
    for (image, name)in images:
        image.save(path_to_save+ name[:name.rfind(".")]+ '.png')

load_images()
images_out=remove_bg(image_list)
save_images(images_out)