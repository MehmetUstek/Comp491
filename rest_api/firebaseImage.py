import datetime
import firebase_admin
from firebase_admin import credentials
from firebase_admin import storage
import urllib.request
import os

cred = credentials.Certificate("comp491-a3e64-firebase-adminsdk-xwzg6-a0b1cef00c.json")
app = firebase_admin.initialize_app(cred, {
    'storageBucket': 'comp491-a3e64.appspot.com',
}, name='storage')

bucket = storage.bucket(app=app)

def retrieveImageByImageId(imageId):
    blob = bucket.blob("images/" + imageId+".png")
    # Get the image from firebase.
    image_location_string = blob.generate_signed_url(datetime.timedelta(seconds=20), method='GET')
    print(image_location_string)
    # Load the image to a local file.
    urllib.request.urlretrieve(image_location_string, imageId+".png")
    # Use the image in here
    ####################
    # ...

    ####################
    # When you are done, delete the image from local.
    os.remove(imageId+".png")

# The example call:
# retrieveImageByImageId("image0sub4")