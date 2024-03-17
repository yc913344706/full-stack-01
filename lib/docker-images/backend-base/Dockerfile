FROM --platform=$TARGETPLATFORM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

# 使用变量必须申明
ARG TARGETOS
ARG TARGETARCH

## 拷贝需要的文件
COPY root/etc/apt/sources.${TARGETARCH}.list /etc/apt/sources.list

RUN apt update -y && \
    apt install -y python3.10 python3-pip python3.10-dev && \
    ln -sf $(which python3.10) /usr/bin/python && \
    python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip && \
    ln -sf $(which pip3) /usr/bin/pip && \
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN apt install -y curl vim language-pack-en

ENV TZ 'Asia/Shanghai'
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# 清理缓存
RUN apt clean all
RUN find /var/lib/apt/lists -type f -delete && \
    find /var/cache -type f -delete
