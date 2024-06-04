#!/usr/bin/env bash

set -euxo pipefail

# Hacky CI to build this in CF Pages
npm install -g pxt
(
  cd ../
  git clone git@github.com:microbit-grace/pxt.git
  cd pxt
  git checkout download-post-message
  npm install
  npm run build
  npm link
)

npm link ../pxt

# Add ml extension
node -e "const f = 'pxtarget.json'; const data = fs.readFileSync(f, 'utf8'); fs.writeFileSync(f, data.replace('\"libs/core\",', '\"libs/core\",\"libs/machine-learning-poc\",\"libs/ml-runner-poc\",'))"
cd libs
git clone -b v0.3.2 git@github.com:microbit-foundation/pxt-ml-runner-poc.git
mv pxt-ml-runner-poc ml-runner-poc
cd ml-runner-poc
node -e "const f = 'pxt.json'; const data = fs.readFileSync(f, 'utf8'); fs.writeFileSync(f, data.replace('*', 'file:../core'))"
pxt install
cd ..
git clone -b v0.3.0 git@github.com:microbit-foundation/pxt-ml-extension-poc.git
mv pxt-ml-extension-poc machine-learning-poc
cd machine-learning-poc
node -e "const f = 'pxt.json'; const data = fs.readFileSync(f, 'utf8'); const output = JSON.parse(data); output.name = 'machine-learning-poc'; output.dependencies.core = 'file:../core'; output.dependencies[\"ml-runner-poc\"] = 'file:../ml-runner-poc'; output.installedVersion = 'github:microbit-foundation/pxt-ml-extension-poc#v0.3.0'; fs.writeFileSync(f, JSON.stringify(output))"
pxt install
cd ../..

pxt staticpkg
