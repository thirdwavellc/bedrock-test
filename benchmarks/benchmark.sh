#!/bin/bash

set -e

function remove_files {
  if [ -a ab.tsv ]; then
    rm ab.tsv
  fi

  if [ -a ab.png ]; then
    rm ab.png
  fi
}

function run_benchmark {
  ab -n 5000 -c 150 -g ab.tsv http://bedrock.stg/
}

function plot_results {
  gnuplot ab.p
}

remove_files
run_benchmark
plot_results
