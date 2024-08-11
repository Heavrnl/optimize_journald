#!/bin/bash

# 1. 打开配置文件并写入设置
echo "调整 journald 配置..."

# 备份现有配置文件
cp /etc/systemd/journald.conf /etc/systemd/journald.conf.bak

# 写入新的配置
cat <<EOL > /etc/systemd/journald.conf
[Journal]
SystemMaxUse=5M
SystemMaxFileSize=2M
SystemKeepFiles=1
EOL

echo "配置已更新。"

# 2. 清理旧日志
echo "清理旧日志..."
journalctl --vacuum-time=1week

# 3. 重启 journald 服务
echo "重启 systemd-journald 服务..."
systemctl restart systemd-journald

echo "操作完成。"
