echo Sonos Api deployment
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo building docker image 

sudo docker build -t "sonos_api" .

if [ "$?" -eq 0 ]; then 
    echo successfully created image
else 
    echo something went wrong building the container image 
    exit 1
fi

echo deploying the container

container_id=$(docker ps --filter "publish=5005" --format "{{.ID}}")

if [ -n "$container_id" ]; then

    echo "Container(s) found using port 5005: $container_id"
else    
    sudo docker run --network=bridge -p 5005:5005 sonos_api
fi