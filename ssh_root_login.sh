#!/bin/bash

# 确保脚本以root权限运行
if [ "$(id -u)" != "0" ]; then
   echo "此脚本需要以root权限运行" 1>&2
   exit 1
fi

# 检查sshd配置文件是否存在
SSHD_CONFIG="/etc/ssh/sshd_config"
if [ ! -f "$SSHD_CONFIG" ]; then
    echo "未找到sshd配置文件：$SSHD_CONFIG"
    exit 1
fi

# 备份原始配置文件
cp $SSHD_CONFIG ${SSHD_CONFIG}.bak

# 更新配置：设置PasswordAuthentication为yes
sed -i 's/^\s*PasswordAuthentication no/PasswordAuthentication yes/' $SSHD_CONFIG
# 如果PasswordAuthentication yes不存在，则添加
if ! grep -q "^PasswordAuthentication yes$" $SSHD_CONFIG; then
    echo "PasswordAuthentication yes" >> $SSHD_CONFIG
fi

# 更新配置：设置PermitRootLogin为yes
sed -i 's/^\s*PermitRootLogin .*/PermitRootLogin yes/' $SSHD_CONFIG
# 如果PermitRootLogin yes不存在，则添加
if ! grep -q "^PermitRootLogin yes$" $SSHD_CONFIG; then
    echo "PermitRootLogin yes" >> $SSHD_CONFIG
fi

# 提示用户修改root密码
echo "建议如果还没有设置一个安全的root密码，请立即修改。"
echo "请使用 'passwd root' 命令来修改root用户的密码。"

# 重启sshd服务
if systemctl is-active --quiet sshd; then
    systemctl restart sshd
else
    service sshd restart
fi

echo "sshd服务已根据新配置重新启动。"
