FROM yc913344706/ubuntu22:python3.10

COPY ./root/root /root

RUN if [ -f /root/requirements.txt ]; then \
        pip install -r /root/requirements.txt; \
    fi

# 清理缓存
RUN apt clean all
RUN find /var/lib/apt/lists -type f -delete && \
    find /var/cache -type f -delete
