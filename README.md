# Caddy OneProxy
使用路径、User Agent等特征实现的 All-in-Boom 反代镜像源，无缓存功能（硬盘真的不够用了）。

对 https://github.com/huangzheng2016/TheOnlyMirror 和 https://github.com/Jlan45/TheOnlyMirror 的拙劣模仿，但是一行代码都没写。

## Support Status
* [x] `git clone https://github.com/...` [github-git](proxy.d/github-git)
* [x] Docker Hub [docker](proxy.d/docker)
* [x] npm [npm](proxy.d/npm)
* [x] raw.githubusercontent.com [ghraw](proxy.d/ghraw)，在路径 `/ghraw` 下

## Usage
构建或[下载](https://caddyserver.com/download?package=github.com%2Fcaddyserver%2Freplace-response)一份带有 [replace-response](https://github.com/caddyserver/replace-response) 模块的 Caddy 二进制文件，然后
使用本项目的 [Caddyfile](Caddyfile)，在启动 Caddy 时添加环境变量 `EXTERNAL_URL`，指向你的 OneProxy 服务地址，推荐使用HTTPS和默认端口。

```shell
# 构建
xcaddy build \
    --with github.com/caddyserver/replace-response

# 启动，环境变量中 URL 不要以 / 结尾
EXTERNAL_URL=https://url_to_your_proxy ./caddy_linux_amd64_custom run
```

为了适应容器环境，默认监听在 `http://*:2345` 端口，未使用 Caddy 的自动 HTTPS 服务，如果有需要可以自行配置。

### Docker
本项目包含一份 Dockerfile，可以直接构建容器并使用，或部署至 fly.io 等支持 Docker 部署的平台。

```toml
# Example fly.toml
app = 'your-app-name'
primary_region = 'nrt'

[build]

[http_service]
  internal_port = 2345
  force_https = true
  auto_stop_machines = true
  auto_start_machines = true
  min_machines_running = 0
  processes = ['app']

[[vm]]
  size = 'shared-cpu-1x'

[env]
  EXTERNAL_URL = "https://your.app.domain"
```