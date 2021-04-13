import boto3

s3_client = boto3.client('s3')

def handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        print('{}-thumbs'.format(bucket), key)
        s3_client.delete_object(Bucket='{}-thumbs'.format(bucket), Key=key)