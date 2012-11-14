PATH=/usr/sbin:/usr/local/bin:$PATH
PATH=$PATH:/sw/bin/:/usr/texbin/

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

# Include
# INCLUDE=$INCLUDE:/opt/local/include

# Go
GOROOT=/usr/local/go
GOOS=darwin
GOARCH=amd64
GOBIN=$GOROOT/bin
PATH=$PATH:$GOBIN
GOPATH=~/Documents/program/go:$GOROOT:.

# Google App Engine for GO
GAEROOT=/usr/local/google_appengine
PATH=$PATH:$GAEROOT

# Scripts
PATH=$PATH:~/scripts
