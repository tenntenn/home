export PATH=/usr/local/bin:$PATH
export PATH=$PATH:/sw/bin/:/usr/texbin/

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

# Include
# export INCLUDE=$INCLUDE:/opt/local/include

# BibTex
export BIBINPUTS=$BIBINPUTS:/Users/ueda/Documents/References/

# Mozilla HTML Parser
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/ueda/Documents/JavaLibrary/MozillaParser-v-0-3-0/dist/macosx/mozilla/

# Swarm
#source /opt/local/etc/swarm/swarmrc

# Android
export PATH=$PATH:/Users/ueda/Documents/android-sdk-mac_x86

# Go
export GOROOT=/usr/local/go
export GOOS=darwin
export GOARCH=amd64
export GOBIN=$GOROOT/bin
export PATH=$PATH:$GOBIN
export GOPATH=~/Documents/program/go:$GOROOT

# Google App Engine for GO
export GAEROOT=/usr/local/google_appengine
export PATH=$PATH:$GAEROOT

# Plan9port
#export PLAN9=/usr/local/plan9
#export PATH=$PATH:$PLAN9/bin

export PATH=$PATH:/usr/local/lib/ruby/gems/1.9.1/gems/sass-3.1.14/bin/

# Node.js
. ~/.nvm/nvm.sh

# Play 2.0
export PATH=$PATH:/usr/local/play-2.0

# JSX
export PATH=$PATH:/usr/local/JSX/bin
