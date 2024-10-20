#!/bin/bash

dataset=("a" "b" "c" "e" "x" "y")
cores=(2 4 8 16 32 64)

# numactl -N 1 -m 1 BP-Tree/btree_tests/ycsb btree a randint zipfian 32

for dataset in "${dataset[@]}"
do
    for core in "${cores[@]}"
    do
        echo "Running dataset $dataset with $core cores on B-Tree"
        numactl -N 1 -m 1 /home/eddy/BP-Tree/btree_tests/ycsb btree $dataset randint zipfian $core
    done
done

for dataset in "${dataset[@]}"
do
    for core in "${cores[@]}"
    do
        echo "Running dataset $dataset with $core cores on bskiplist"
        numactl -N 1 -m 1 /home/eddy/bskiplist/ycsb btree $dataset randint zipfian $core
    done
done
