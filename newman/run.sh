HOST=localhost:8080
TEMPLATE_FILE=template_environment.json
COLLECTION=student_java.postman_collection.json

if [ ! -z "$1" ]; then
  echo "using host $1..."
  HOST=$1
fi

sed -- "s|HOST_TEMPLATE|${HOST}|" ${TEMPLATE_FILE}>>temp.json
newman run --delay 100 -e temp.json $COLLECTION
rm -f temp.json
