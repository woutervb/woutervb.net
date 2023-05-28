#!/bin/bash

date=$(date +%Y-%m-%d)

hugo new "posts/${date}-${1}"
