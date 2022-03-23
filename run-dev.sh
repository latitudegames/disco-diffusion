sudo cog build
sudo docker run --rm --shm-size 8G --gpus all --interactive --tty -v /mnt/model-storage:/mnt/models --workdir /src latitudetech/disco-diffusion:$1 /bin/bash
