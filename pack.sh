#!/bin/bash

name=$1

if [ $name == "thumb_create" ]; then
	cp python_lambda.zip dist/$name.zip
	zip -g dist/$name.zip $name.py
	zip -g dist/$name.zip ffmpeg
	exit 0
fi

if [ $name == "thumb_delete" ]; then
	cp python_lambda.zip dist/$name.zip
	zip -g dist/$name.zip $name.py
	exit 0
fi

echo "invalid name of function"
exit 1