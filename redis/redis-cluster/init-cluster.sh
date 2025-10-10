#!/bin/bash

# Redis Cluster 初始化脚本 - 3主3从配置
# 使用方法: ./init-cluster.sh

# 读取环境变量
source .env

echo "等待所有Redis节点启动..."
sleep 10

echo "创建Redis集群 (3主3从)..."
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

echo ""
echo "集群创建完成！"
echo ""
echo "检查集群状态..."
docker exec -it redis-node1 redis-cli -a "${REDIS_PASSWORD}" cluster info
echo ""
echo "查看集群节点..."
docker exec -it redis-node1 redis-cli -a "${REDIS_PASSWORD}" cluster nodes
