#!/bin/bash -ex

curl -s https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar xz -C /opt/

cat <<'EOF' > /etc/profile.d/golang.sh
export GOPATH=/opt/gopkg
export GOROOT=/opt/go
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
EOF

chmod +x /etc/profile.d/golang.sh
