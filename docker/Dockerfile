FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

LABEL org.opencontainers.image.authors="aprados@ianservision.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get upgrade -y && apt-get install -yqq --no-install-recommends \
	libgl1 libglib2.0-0 \
	python3-pip python-is-python3 \
	python3 python3-venv \
	git git-lfs\
	wget \
	vim \
	pkg-config \
	aria2 \
	inetutils-ping \
	sudo \
	net-tools \
	iproute2 \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


# Create user and avoid using root
RUN adduser --disabled-password --gecos '' user
RUN mkdir /content && chown -R user:user /content
WORKDIR /content
USER user

# Clone repositories: TODO -> Submodules
RUN git clone -b iav/main https://github.com/andresprados/stable-diffusion-webui
RUN git clone https://github.com/andresprados/adetailer /content/stable-diffusion-webui/extensions/adetailer
RUN git clone https://github.com/andresprados/sd-webui-controlnet /content/stable-diffusion-webui/extensions/sd-webui-controlnet

# Installation
WORKDIR /content/stable-diffusion-webui/
RUN ./webui.sh --exit --skip-torch-cuda-test

ENV VIRTUAL_ENV=/content/stable-diffusion-webui/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Pytorch 2.0.1 bug
WORKDIR /content/stable-diffusion-webui/venv/lib/python3.10/site-packages/torch/lib
RUN ln -s libnvrtc-672ee683.so.11.2 libnvrtc.so

WORKDIR /content/stable-diffusion-webui

# Is truly need it?
VOLUME /root/.cache

EXPOSE 7860

CMD ["python3", "launch.py", "--listen"]