# Redis 集群部署 (3主3从)

这是一个Redis分布式集群的最小部署方案，采用3主3从架构。

## 架构说明

- **6个Redis节点**: redis-node1 到 redis-node6
- **3个主节点**: 自动选举，通常是前3个节点
- **3个从节点**: 每个主节点配置1个从节点
- **端口映射**:
  - 客户端端口: 7000-7005 (映射到容器内的6379)
  - 集群总线端口: 17000-17005 (映射到容器内的16379)

## 快速启动

### 1. 配置环境变量

确保 `.env` 文件存在并设置了 `REDIS_PASSWORD`:

```bash
REDIS_PASSWORD=your_secure_password_here
```

### 2. 启动所有节点

```bash
docker-compose up -d
```

### 3. 初始化集群

```bash
./init-cluster.sh
```

这个脚本会自动创建3主3从的集群配置。

## 手动初始化集群

如果你想手动初始化集群，可以执行:

```bash
# 读取密码
source .env

# 创建集群
docker exec -it redis-node1 redis-cli \
  -a "${REDIS_PASSWORD}" \
  --cluster create \
  redis-node1:6379 \
  redis-node2:6379 \
  redis-node3:6379 \
  redis-node4:6379 \
  redis-node5:6379 \
  redis-node6:6379 \
  --cluster-replicas 1 \
  --cluster-yes
```

## 验证集群状态

### 查看集群信息

```bash
docker exec -it redis-node1 redis-cli -a "${REDIS_PASSWORD}" cluster info
```

### 查看集群节点

```bash
docker exec -it redis-node1 redis-cli -a "${REDIS_PASSWORD}" cluster nodes
```

### 测试集群

```bash
# 连接到集群
docker exec -it redis-node1 redis-cli -c -a "${REDIS_PASSWORD}"

# 在Redis CLI中测试
> SET key1 "value1"
> GET key1
> CLUSTER INFO
> exit
```

## 管理命令

### 停止集群

```bash
docker-compose down
```

### 停止并删除数据

```bash
docker-compose down -v
rm -rf redis-node*-data/*
```

### 查看日志

```bash
# 查看所有节点日志
docker-compose logs -f

# 查看特定节点日志
docker-compose logs -f redis-node1
```

## 数据持久化

- 数据存储在本地目录: `redis-node1-data` 到 `redis-node6-data`
- 使用RDB和AOF双重持久化机制
- RDB快照策略:
  - 900秒内至少1次修改
  - 300秒内至少10次修改
  - 60秒内至少10000次修改

## 安全配置

- 启用了密码认证 (requirepass/masterauth)
- 禁用了危险命令 (FLUSHALL, FLUSHDB)
- 集群节点间通信需要认证

## 故障转移

- 集群会自动检测节点故障
- 当主节点失败时，其从节点会自动提升为主节点
- 节点超时时间: 5000ms

## 注意事项

1. 确保所有端口 (7000-7005, 17000-17005) 未被占用
2. 生产环境请修改默认密码
3. 建议配置防火墙规则限制集群总线端口访问
4. 定期备份数据目录
