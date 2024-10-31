#!/bin/bash

dataset=("a" "b" "c" "e" "x" "y")
cores=(32 64)

btree_path=~/BP-Tree/btree_tests/ycsb
bskiplist_path=~/bskiplist/ycsb

# numactl -N 1 -m 1 BP-Tree/btree_tests/ycsb btree a randint zipfian 32

for dataset in "${dataset[@]}"
do
    for core in "${cores[@]}"
    do
        echo "Running dataset $dataset with $core cores on bskiplist"
        numactl -N 1 -m 1 $btree_path btree $dataset randint zipfian $core
    done
done
