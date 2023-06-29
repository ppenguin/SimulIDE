#!/usr/bin/env bash

repo=simulide
ver=1.0.1
rev=1425

curl -sL "https://bazaar.launchpad.net/~arcachofo/$repo/$ver/tarball/$rev" | tar -zxv -C $(pwd) --strip-components=3 -f -
