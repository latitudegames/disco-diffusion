FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update &&  apt-get install -y build-essential wget vim git ffmpeg

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda install python=3.8
RUN conda install pytorch=1.10.2 cudatoolkit=11.3 torchvision -c pytorch
RUN conda install numpy

RUN pip install -f https://download.pytorch.org/whl/cu113/torch_stable.html  lpips==0.1.4 DateTime==4.4 matplotlib==3.5.1 boto3==1.21.13 omegaconf==2.0.0 pytorch-lightning==1.0.8 einops==0.4.1 torch-fidelity==0.3.0 wandb==0.12.11 fvcore==0.1.5.post20220305 iopath==0.1.9 opencv-python==4.5.5.64 timm==0.5.4 pandas==1.4.1

RUN git clone https://github.com/openai/CLIP src/CLIP
RUN git clone https://github.com/facebookresearch/SLIP.git src/SLIP
RUN git clone https://github.com/crowsonkb/guided-diffusion src/guided-diffusion
RUN git clone https://github.com/assafshocher/ResizeRight.git src/ResizeRight && mv src/ResizeRight/* src
RUN git clone https://github.com/isl-org/MiDaS.git src/MiDaS && mv src/MiDaS/utils.py src/midas_utils.py && mv src/MiDaS/midas src/midas
RUN git clone https://github.com/alembics/disco-diffusion src/disco-diffusion
RUN git clone https://github.com/CompVis/latent-diffusion.git src/latent-diffusion && mv src/latent-diffusion/ldm src/ldm
RUN git clone https://github.com/shariqfarooq123/AdaBins.git src/AdaBins
RUN pip install -e ./src/CLIP
RUN pip install -e ./src/guided-diffusion
RUN pip install git+https://github.com/Latitude-Archives/taming-transformers.git@cf4d9d388ff66bd64f6da233ffc082145e2e04f5
RUN pip install --no-index --no-cache-dir pytorch3d -f https://dl.fbaipublicfiles.com/pytorch3d/packaging/wheels/py38_cu111_pyt1100/download.html
WORKDIR /src
COPY . /src