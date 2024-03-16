FROM --platform=$TARGETPLATFORM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

# 使用变量必须申明
ARG TARGETOS
ARG TARGETARCH

## 拷贝需要的文件
COPY root/etc/apt/sources.${TARGETARCH}.list /etc/apt/sources.list

RUN apt update -y
RUN apt install -y python3.10
