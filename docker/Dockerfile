FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

LABEL org.opencontainers.image.authors="aprados@ianservision.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -yqq --no-install-recommends \
	libgl1 libglib2.0-0 \
	python3 python3-venv \
	git \
	wget \
	vim \
	aria2 \
	inetutils-ping \
	sudo \
	net-tools \
	iproute2 \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY webui.sh webui.sh

ENV install_dir=/
RUN ./webui.sh -f can_run_as_root --exit --skip-torch-cuda-test

ENV VIRTUAL_ENV=/stable-diffusion-webui/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

WORKDIR "/stable-diffusion-webui/venv/lib/python3.10/site-packages/torch/lib"
RUN ln -s libnvrtc-672ee683.so.11.2 libnvrtc.so

WORKDIR "/stable-diffusion-webui/"
VOLUME /root/.cache



CMD ["python3", "launch.py", "--listen"]