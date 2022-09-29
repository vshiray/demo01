#!/bin/bash -e

update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

apt-get update

apt-get -y install git

git clone https://github.com/vshiray/demo01.git /opt/demo01

cat >/etc/systemd/system/demo01.service <<END
[Unit]
Description=Demo Application

[Service]
Type=simple
User=nobody
WorkingDirectory=/opt/demo01
ExecStart=/opt/demo01/app/demo-amd64
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable demo01
systemctl start demo01
