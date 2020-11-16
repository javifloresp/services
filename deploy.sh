#!/usr/bin/env bash

# Create deploy folder
mkdir -p /var/www/$1/{httpdocs,logs}
mkdir -p /var/deploys/$1

# Generate deploy
cd /var/deploys/$1
git init --bare
cat > /var/deploys/$1/hooks/post-receive <<EOF
#!/bin/sh
echo "Inicia $1"
git --work-tree=/var/www/$1/httpdocs/  --git-dir=/var/deploys/$1  checkout -f alpha
echo "Termina $1"
EOF

# Assign permissions to user
chown -R webdev:webdev /var/www/$1
chown -R webdev:webdev /var/deploys/$1
chmod +x /var/deploys/$1/hooks/post-receive
