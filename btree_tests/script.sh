percentages=(1 5 10 25 75 100)

for i in "${percentages[@]}"
    numactl -N 1 -m 1 ./ycsb /home/eddy/datasets/uniform/uniform/insert_$i/ a 64 insert_$i.csv


numactl -N 1 -m 1 ./ycsb /home/eddy/datasets/uniform/ c 64 insert_0.csv
numactl -N 1 -m 1 ./ycsb /home/eddy/datasets/uniform/ a 64 insert_50.csv
