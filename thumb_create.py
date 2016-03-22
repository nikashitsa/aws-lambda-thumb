from __future__ import print_function
from boto3.s3.transfer import S3Transfer
import boto3
import os
import sys
import uuid
from PIL import Image
import PIL.Image

s3_client = boto3.client('s3')
transfer = S3Transfer(s3_client)
thumb_size = 200, 200

def resize_image(image_path, resized_path):
    with Image.open(image_path) as image:
        image.thumbnail(thumb_size)
        image.save(resized_path)

def handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        rand = uuid.uuid4()
        download_path = '/tmp/{}'.format(rand)
        upload_path = '/tmp/thumb-{}.jpg'.format(rand)

        response = s3_client.head_object(Bucket=bucket, Key=key)
        type = response['ContentType']

        if type not in ['image/png', 'image/jpg', 'image/jpeg']:
          print(type, 'is not supported')
          continue

        transfer.download_file(bucket, key, download_path)
        resize_image(download_path, upload_path)
        transfer.upload_file(upload_path, '{}-thumbs'.format(bucket), key, extra_args={'ContentType': 'image/jpeg'})