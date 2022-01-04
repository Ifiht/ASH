#!/bin/bash

git pull
git submodule deinit -f $1
git rm $1
git commit -m "removed sub"
rm -rf .git/modules/$1
git push
