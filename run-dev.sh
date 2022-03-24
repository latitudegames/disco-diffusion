sudo docker build -t latitudetech/disco-diffusion:$1 .
sudo docker run --rm --shm-size 8G --gpus all --interactive --tty -v /mnt/model-storage:/mnt/models --workdir /src latitudetech/disco-diffusion:$1 /bin/bash
