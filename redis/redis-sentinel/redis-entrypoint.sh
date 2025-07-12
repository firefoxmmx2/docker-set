#!/bin/sh
set -e

# 原始配置文件路径由命令的第一个参数传入
ORIGINAL_CONF_FILE="$1"
TEMP_CONF_FILE="/tmp/redis.conf"

# 检查原始配置文件是否存在
if [ ! -f "$ORIGINAL_CONF_FILE" ]; then
    echo "FATAL: Redis configuration file not found at $ORIGINAL_CONF_FILE"
    exit 1
fi

# 复制配置文件到临时位置
cp "$ORIGINAL_CONF_FILE" "$TEMP_CONF_FILE"

# 将 ${REDIS_PASSWORD} 占位符替换为环境变量中的真实密码
# 使用 sed 命令将 ${REDIS_PASSWORD} 占位符替换为环境变量中的真实密码
# sed 's|search|replace|g' 是一种更安全的写法，可以避免密码中包含 / 字符导致的问题
sed -i "s|\${REDIS_PASSWORD}|$REDIS_PASSWORD|g" "$TEMP_CONF_FILE"

echo "Starting redis-server with dynamic configuration:"
cat "$TEMP_CONF_FILE"

# 使用修改后的临时配置启动 Redis Server
exec redis-server "$TEMP_CONF_FILE"
