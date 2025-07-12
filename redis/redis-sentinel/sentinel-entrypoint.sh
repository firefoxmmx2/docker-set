#!/bin/sh
set -e

SENTINEL_CONF_FILE="/usr/local/etc/redis/sentinel.conf"
TEMP_CONF_FILE="/tmp/sentinel.conf"

# 等待直到 redis-master 可被解析
until ping -c 1 redis-master > /dev/null 2>&1; do
  echo "Waiting for redis-master to be resolvable..."
  sleep 1
done
echo "redis-master is resolvable."

# 获取 redis-master 的 IP 地址
MASTER_IP=$(ping -c 1 redis-master | grep 'PING' | sed -n 's/.*(\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\)).*/\1/p')

if [ -z "$MASTER_IP" ]; then
    echo "FATAL: Could not resolve redis-master IP address."
    exit 1
fi

echo "Resolved redis-master IP to: $MASTER_IP"

# 复制配置文件到临时位置
cp "$SENTINEL_CONF_FILE" "$TEMP_CONF_FILE"

# 将 ${REDIS_PASSWORD} 占位符替换为环境变量中的真实密码
sed -i "s/\${REDIS_PASSWORD}/$REDIS_PASSWORD/g" "$TEMP_CONF_FILE"

# 将主机名替换为 IP 地址
sed -i "s/redis-master/$MASTER_IP/g" "$TEMP_CONF_FILE"

echo "Starting sentinel with dynamic configuration:"
cat "$TEMP_CONF_FILE"

# 使用修改后的临时配置启动 Sentinel
exec redis-server "$TEMP_CONF_FILE" --sentinel
