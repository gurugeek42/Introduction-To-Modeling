#!/usr/bin/env bash

save_folder="data/staircase_attempt_1"

mkdir -p $save_folder
rm -f $save_folder/*

cat << EOF > $save_folder/constants.js
{
  "Pr":7,
  "Ra":1.3e5,
  "RaXi":1e7,
  "tau":1e-2,
  "aspectRatio":1.41421356237,
  "initialDt":1e-7,

  "nN":101,
  "nZ":201,

  "icFile":"$save_folder/ICn1nZ256nN128_SF",
  "saveFolder":"$save_folder/",

  "timeBetweenSaves":0.001,
  "totalTime":1,

  "isNonlinear":true,
  "isDoubleDiffusion":true
}
EOF

constants_file=$save_folder/constants.js
python tools/make_initial_conditions.py --output $save_folder/ICn1nZ256nN128_SF --n_modes 128 --n_gridpoints 256 --modes 20 25 --amp 0.01 --salt_fingering

echo "==================== Building program"
make release

echo "==================== Starting program"
{ time build/exe --constants $constants_file ; } 2>&1 | tee $save_folder/log.txt
