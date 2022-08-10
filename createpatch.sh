#!/bin/bash
name=$1
if [ name == "" ]; then
  echo "Specify the path name"
  exit
fi
patches=$(ls patches/*.diff)
lastpatch=$(echo "$patches" | tail -n1)
lastpatch=${lastpatch:8:3}
currentpatch="$(($lastpatch + 1))"

while [ ${#currentpatch} -lt 3 ]; do
  currentpatch="0$currentpatch"
done

filename="$currentpatch-$name.diff"
cd src

if [ "$(git status -s)" == "" ]; then
  echo "Nothing changed. Cancelling..."
  exit
fi

git add .
git commit -m "patch $currentpatch - $name"
git show > "../patches/$filename"
