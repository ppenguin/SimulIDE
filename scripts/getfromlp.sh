#!/usr/bin/env bash

repo=simulide
ver=trunk
rev=1723

curl -sL "https://bazaar.launchpad.net/~arcachofo/$repo/$ver/tarball/$rev" | tar -zxv -C $(pwd) --strip-components=3 -f -
