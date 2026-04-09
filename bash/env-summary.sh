#!/bin/bash

echo "user = $USER"
echo "shell = $SHELL"
echo "cwd  = $(pwd)"
echo "host = $(hostname)"
echo "uptime = $(uptime -p)"

echo ""
echo "environment summary complete"
