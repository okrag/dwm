#!/bin/bash
rm -rf src
mkdir -p src
cd src
git clone https://git.suckless.org/dwm .

patch_error() {
  patchnumber=$0
  patchname=$1

  echo "Canno apply \"patch $patchnumber - $patchname\""
  mkdir -p ../rejected
  mv *.rej ../rejected/
  rm -f *.orig
  exit 1
}

patches=$(ls ../patches/*.patch)
for patch in $patches; do
  echo "========== applying \"patch ${patch:11:3} - ${patch:15:-5}\" =========="
  patch -p1 < $patch || patch_error ${patch:11:3} ${patch:15:-5}
  rm -f *.orig
  git add .
  git commit -m "patch ${patch:11:3} - ${patch:15:-5}"
done


