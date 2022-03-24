echo $AWS_ACCESS_KEY_ID
sudo docker build -t latitudetech/disco-diffusion:$1 .
sudo docker run --rm --shm-size 8G --gpus all --interactive --tty -v /mnt/model-storage:/mnt/models --workdir /src -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_REGION=$AWS_REGION -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY latitudetech/disco-diffusion:$1 /bin/bash
