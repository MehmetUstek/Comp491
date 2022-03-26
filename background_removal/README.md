Instal required packages 

pip install -r requirements.txt

Download model into model folder 

gdown --id 1ao1ovG1Qtx4b7EoskHXmi2E9rp5CHLcZ -O ./model/u2net.pth

RUN

python3 remove_bg.py input_image_folder output_image_folder
