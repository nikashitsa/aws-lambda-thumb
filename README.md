# aws-lambda-thumb
AWS Lambda. Creates/removes thumbnails via Python 3.8. 8x faster than nodejs.

`thumb_create` function creates thumbnail in thumbnails bucket when original image is uploaded.

`thumb_delete` function removes thumbnail from thumbnails bucket when original image is removed.

## Usage
1. Add bucket for thumbnails with suffix `-thumbs`. E.g. for `mybucket` new bucket should be `mybucket-thumbs`.
2. Add object delete permission ("s3:DeleteObject") to your lambda s3 role `lambda_s3_exec_role`.
3. Create .zip archives in `dist/`
```
./pack.sh thumb_create
./pack.sh thumb_delete
./pack.sh python_layer # (requires virtualenv & docker)
./pack.sh ffmpeg_layer # (requires wget)
```
4. Add python and ffmpeg layers to thumb_create function.

Handlers will be `thumb_create.handler` and `thumb_delete.handler` for lambda functions.

## Performance (thumb_create)
- Average time for image 3.8mb ([nodejs](http://docs.aws.amazon.com/lambda/latest/dg/with-s3-example-deployment-pkg.html)): 5.7 sec
- Average time for image 3.8mb (aws-lambda-thumb): 0.7 sec
