# remove container if exist
if [ "$(docker container inspect $1)" ]; then
  docker rm -f $1
  echo "Container Removed => $1"
fi
# remove image if exist
if [ "$(docker image inspect $2)" ]; then
  docker rmi $2
  echo "Image Removed => $2"
fi