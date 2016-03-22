name=$1
cp python_lambda.zip dist/$name.zip
zip -g dist/$name.zip $name.py