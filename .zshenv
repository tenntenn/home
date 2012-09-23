PATH=/usr/sbin:/usr/local/bin:$PATH
PATH=$PATH:/sw/bin/:/usr/texbin/

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

# Include
# INCLUDE=$INCLUDE:/opt/local/include

# BibTex
BIBINPUTS=$BIBINPUTS:/Users/ueda/Documents/References/

# Mozilla HTML Parser
DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/ueda/Documents/JavaLibrary/MozillaParser-v-0-3-0/dist/macosx/mozilla/

# Swarm
#source /opt/local/etc/swarm/swarmrc

# Android
PATH=$PATH:/Users/ueda/Documents/android-sdk-mac_x86

# Go
GOROOT=/usr/local/go
GOOS=darwin
GOARCH=amd64
GOBIN=$GOROOT/bin
PATH=$PATH:$GOBIN
GOPATH=~/Documents/program/go:$GOROOT

# Google App Engine for GO
GAEROOT=/usr/local/google_appengine
PATH=$PATH:$GAEROOT

# Plan9port
#PLAN9=/usr/local/plan9
#PATH=$PATH:$PLAN9/bin

PATH=$PATH:/usr/local/lib/ruby/gems/1.9.1/gems/sass-3.1.14/bin/

# Node.js
. ~/.nvm/nvm.sh

# Play 2.0
PATH=$PATH:/usr/local/play-2.0

# JSX
PATH=$PATH:/usr/local/JSX/bin
