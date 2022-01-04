#!/bin/sh
sudo apt install libpolyml-dev polyml
git clone https://github.com/HOL-Theorem-Prover/HOL.git
cd HOL
git branch --set-upstream-to=origin/release-masters
git checkout tags/kananaskis-13 -b release-masters
sudo poly < tools/smart-configure.sml
