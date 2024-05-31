#!/usr/bin/env bash

set -euxo pipefail

# Hacky CI to build this in CF Pages
npm install -g pxt
cd ../
git clone git@github.com:microbit-grace/pxt.git
cd pxt
git checkout download-post-message
npm install
npm run build
npm link

cd ../pxt-microbit
npm link ../pxt
pxt staticpkg
