#!/bin/bash

cat ../configs/services.txt | sort -k3 -n | tail -20
