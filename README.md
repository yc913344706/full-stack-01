- [说明](#说明)
- [使用](#使用)
  - [本机直接使用](#本机直接使用)
  - [远程服务器使用](#远程服务器使用)
  - [本机debug](#本机debug)
- [FAQ](#faq)
  - [问题 1：网段冲突问题](#问题-1网段冲突问题)
  - [问题 2：端口占用问题](#问题-2端口占用问题)
- [doc](#doc)
  - [github 密码鉴权失败问题](#github-密码鉴权失败问题)

## 说明

做一个前端、后端、运维套装。

-   能看懂的，若有心情，高台鬼手，帮我改改，谢谢。
-   看不懂的，请不要乱动，谢谢。

- 前端：node:20.11.1, vue3, vite, ts
- 后端：python3.10, django==5.0.3
- 运维：docker-compose
  - 支持系统：linux/arm64,linux/amd64


> 注：
> -   github: https://github.com/yc913344706/full-stack-base.git
> -   gitee: https://gitee.com/ycvayne/full-stack-base.git

## 使用

### 本机直接使用

```shell
# 启动
./bin/start.sh
# 注：网络正常，约25s~60s不等（第一次需下载镜像除外）


# 查看状态
./bin/status.sh


# 停止
./bin/stop.sh
```

### 远程服务器使用

```shell
# 修改前端调用后端地址。修改 production 即可
[root@ubuntu ~/yuchuan/gitee/full-stack-base]# grep -C1 baseURL frontend/src/config/httpConfig.ts
    dev: {
        baseURL: 'http://localhost:8000', // 请求基础地址,可根据环境自定义
    },
    production: {
        baseURL: 'http://192.168.20.215:18000', // 请求基础地址,可根据环境自定义
    },

# 其余步骤同上
```

### 本机debug

[参考](./doc/use/local_debug.md)

## FAQ

### 问题 1：网段冲突问题

> Question:

```text
 ✘ Network yc_ley_yc_ley   Error 0.0s
failed to create network yc_ley_yc_ley: Error response from daemon: Pool overlaps with other one on this address space
```

> [Answer](./doc/faq/01-网段冲突.md)


### 问题 2：端口占用问题

> Question:

```text
Error response from daemon: driver failed programming external connectivity on endpoint yc_ley_backend_django (caf4e2673fc0d2f5d579bd97e22b6b3d
df435cb4ac2e3d2016d3546beceef8a2): Error starting userland proxy: listen tcp4 0.0.0.0:18000: bind: address already in use
```

> [Answer](./doc/faq/02-端口占用.md)

## doc

### github 密码鉴权失败问题

-   https://blog.csdn.net/qq_32614525/article/details/121124216
