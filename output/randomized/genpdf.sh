#! /bin/bash

for numerr in 0 5 13 37
do
    for i in 1 2 3 4 5
    do
	fname=${numerr}err_$i.csv
	python3 ../../spy.py $fname ber_${numerr}err_95_05_6_${i}_shaded.pdf shade minindices_$fname
    done
done
