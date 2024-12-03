#!/bin/bash

Sudo yum install httpd -y
Sudo systemctl start httpd
Sudo groupadd cloud
Sudo useradd serge -g cloud