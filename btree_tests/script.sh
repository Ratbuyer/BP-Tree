#!/bin/bash

dataset=("a" "b" "c" "e" "x" "y")
cores=(2 4 8 16 32 64)

btree_path=/home/eddy/BP-Tree/btree_tests/ycsb
bskiplist_path=/home/eddy/bskiplist/ycsb

# numactl -N 1 -m 1 BP-Tree/btree_tests/ycsb btree a randint zipfian 32

for dataset in "${dataset[@]}"
do
    for core in "${cores[@]}"
    do
        echo "Running dataset $dataset with $core cores on bskiplist"
        numactl -N 1 -m 1 $bskiplist_path btree $dataset randint zipfian $core
    done
done

for core in "${cores[@]}"
do
    echo "Running dataset x with $core cores on bskiplist"
    numactl -N 1 -m 1 $btree_path btree x randint zipfian $core

    echo "Running dataset y with $core cores on bskiplist"
    numactl -N 1 -m 1 $btree_path btree y randint zipfian $core
done
