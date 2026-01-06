
# serial submission (one after the other)
for i in $(seq 1 60); do
  sbatch submitFM.sh "$i"
done
