#!/bin/bash

# 创建目录并进入
mkdir -p /etc/XrayR
cd /etc/XrayR

# 下载并解压 XrayR 二进制文件
echo "Downloading XrayR..."
wget https://github.com/XrayR-project/XrayR/releases/download/v0.9.3/XrayR-linux-64.zip
if [ $? -ne 0 ]; then
    echo "Failed to download XrayR. Exiting."
    exit 1
fi

echo "Extracting XrayR..."
unzip XrayR-linux-64.zip
if [ $? -ne 0 ]; then
    echo "Failed to unzip XrayR. Exiting."
    exit 1
fi

# 返回 root 目录
cd /root

# 下载并重命名安装脚本
echo "Downloading install script..."
wget -O install_xrayr.sh "https://alist.xiercloud.top/d/%E5%85%B1%E4%BA%AB%E6%96%87%E4%BB%B6%E5%A4%B9/install_xrayr.sh?sign=P68HFkyHtFZNiJUjzXWT8NnGzKsRwF0_GYDU3wB5CBw=:0"
if [ $? -ne 0 ]; then
    echo "Failed to download install script. Exiting."
    exit 1
fi

# 添加可执行权限
chmod +x install_xrayr.sh

# 运行安装脚本
echo "Running install script..."
./install_xrayr.sh
if [ $? -ne 0 ]; then
    echo "Failed to execute install script. Exiting."
    exit 1
fi

# 设置快捷命令
echo "Setting up 'xr' command..."
if ! grep -q "alias xr=" ~/.bashrc; then
    echo "alias xr='systemctl restart XrayR && echo XrayR service restarted'" >> ~/.bashrc
    echo "Shortcut 'xr' added. Please run 'source ~/.bashrc' or restart the terminal to use it."
else
    echo "'xr' command is already set up."
fi

echo "Installation complete."
