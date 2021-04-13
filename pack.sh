#!/bin/bash

name=$1

if [ $name == "thumb_create" ]; then
	rm -f ./dist/$name.zip
	zip -r ./dist/$name.zip $name.py
	exit 0
fi

if [ $name == "thumb_delete" ]; then
	rm -f ./dist/$name.zip
	zip -r ./dist/$name.zip $name.py
	exit 0
fi

if [ $name == "python_layer" ]; then
	virtualenv venv --python=python3.8
	source venv/bin/activate
	pip install Pillow
	pip freeze > requirements.txt
	docker run --rm \
		--volume=$(pwd):/lambda-build \
		-w=/lambda-build \
		lambci/lambda:build-python3.8 \
		pip install -r requirements.txt --target python
	rm -f ./dist/$name.zip
	zip -r ./dist/$name.zip ./python/
	rm -rf ./python ./venv ./requirements.txt
	deactivate
	exit 0
fi

if [ $name == "ffmpeg_layer" ]; then
	wget --progress=dot:mega https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
	tar xvf ffmpeg-release-amd64-static.tar.xz
	mkdir -p ffmpeg/bin
	mv ffmpeg-4.4-amd64-static/ffmpeg ffmpeg/bin/
	rm -f ./dist/$name.zip
	cd ffmpeg
	zip -r ../dist/$name.zip .
	cd ..
	rm -rf ./ffmpeg-4.4-amd64-static ./ffmpeg ./ffmpeg-release-amd64-static.tar.xz
	exit 0
fi

echo "invalid name of function"
exit 1