#!/bin/bash
rm -rf src
mkdir -p src
cd src
cp -r ../origin/* .
git init
git add .
git commit -m "Init"

patches=$(ls ../patches/*.diff)
for patch in $patches; do
  echo "========== applying \"patch ${patch:11:3} - ${patch:15:-5}\" =========="
  patch < $patch
  rm -f *.orig
  git add .
  git commit -m "patch ${patch:11:3} - ${patch:15:-5}"
done


