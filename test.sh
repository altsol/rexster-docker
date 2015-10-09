#!/bin/bash

echo " --> Starting container"
ID=`docker run -d $NAME:$VERSION`
sleep 3

echo " --> Obtaining IP"
DOCKERIP=`docker inspect $ID | grep \"IPAddress\": | sed -e 's/.*: "//; s/".*//'`
if [[ "$DOCKERIP" = "" ]]; then
  echo "Unable to obtain container IP"
fi

URL="http://${DOCKERIP}:8182/graphs/tinkergraph/tp/gremlin?script=g.V()"
GRAPH=`curl -s "$URL"`
success=`echo $GRAPH | jq '.success'`
length=`echo $GRAPH | jq '.results | length'`

if [[ "$success" = "true" && "$length" = "6" ]]; then
  echo "All Tests OK"
else
  echo "Test Failure"
fi

echo " --> Stopping container"
docker stop $ID >/dev/null
docker rm -v $ID >/dev/null
