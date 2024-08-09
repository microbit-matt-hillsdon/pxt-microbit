#!/usr/bin/env bash

set -euxo pipefail

# Hacky CI to build this in CF Pages
npm install -g pxt
(
  cd ../
  git clone git@github.com:microbit-grace/pxt.git
  cd pxt
  git checkout ml-tool
  npm install
  npm run build
  npm link
)

npm link ../pxt
pxt staticpkg
cp 404.html built/packaged/
