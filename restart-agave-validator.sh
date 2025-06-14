#!/bin/bash

echo "🔄 Reloading systemd daemon..."
systemctl daemon-reexec
systemctl daemon-reload

echo "🚦 Restarting Agave Validator service..."
systemctl restart agave-validator.service

echo "✅ Done. Checking status:"
systemctl status agave-validator.service --no-pager