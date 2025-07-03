# n8n Docker 部署

这是一个使用 Docker Compose 部署 n8n 工作流自动化平台的配置。

## 目录结构

```
.
├── docker-compose.yml  # Docker Compose 配置文件
├── data/               # n8n 数据目录（将自动创建）
└── README.md           # 说明文档
```

## 快速开始

### 启动服务

```bash
docker-compose up -d
```

### 查看日志

```bash
docker-compose logs -f
```

### 停止服务

```bash
docker-compose down
```

## 访问 n8n

服务启动后，可以通过浏览器访问：

```
http://localhost:5678
```

## 配置说明

docker-compose.yml 文件中包含了详细的配置注释，你可以根据需要修改以下内容：

- 端口映射：默认为 5678
- 环境变量：包括主机名、协议、时区等
- 安全设置：可选的基本认证
- 数据库配置：默认使用 SQLite，可选配置 PostgreSQL
- 执行设置：超时时间等

## 数据持久化

所有 n8n 数据都存储在当前目录的 `data` 文件夹中，确保该目录有适当的权限。

## 高级配置

如需使用 PostgreSQL 数据库或 Redis 缓存，请取消 docker-compose.yml 文件中相应部分的注释并进行配置。
