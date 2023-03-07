#!/bin/bash

INSTANCE_PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
export INSTANCE_PUBLIC_IP && docker-compose up -d
