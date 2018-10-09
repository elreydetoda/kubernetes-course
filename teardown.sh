#!/usr/bin/env bash

teardown_array=( pods services deployments )

for area in ${teardown_array[@]} ; do
  echo $area
done
