#!/usr/bin/env bash

set -e

save_folder="test/benchmark"

mkdir -p $save_folder
rm -f $save_folder/*

cat << EOF > $save_folder/constants.js
{
  "Pr":0.5,
  "Ra":1,
  "aspectRatio":3,

  "nN":51,
  "nZ":101,

  "icFile":"$save_folder/ICn1nZ101nN51",
  "saveFolder":"$save_folder/",

  "initialDt":1e-5,
  "timeBetweenSaves":0.01,
  "totalTime":10,

  "isNonlinear":false,
  "isDoubleDiffusion":false
}
EOF

constants_file=$save_folder/constants.js
python tools/make_initial_conditions.py --output $save_folder/ICn1nZ101nN51 --n_modes 51 --n_gridpoints 101 --linear_stability

echo "==================== Building program"
make release

echo "==================== Starting program"
{ /usr/bin/time build/exe --constants $constants_file ; } 2>&1 | tee $save_folder/log

if grep -q "Critical Ra FOUND" $save_folder/log; then
  exit 0
else
  exit -1
fi
