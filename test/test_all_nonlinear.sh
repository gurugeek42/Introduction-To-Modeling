#!/usr/bin/env bash

echo "Test: nonlinear without double diffusion"
OUTPUT=$(test/nonlinear_test.sh)
STATUS=$?
if [ $STATUS ]; then
  echo "PASSED"
else
  echo "FAILED"
fi
echo "Time: " $(echo $OUTPUT | grep -oh "real\s[0-9]*m[0-9]*\.[0-9]*s\suser\s[0-9]*m[0-9]*\.[0-9]*s\ssys\s[0-9]*m[0-9]*\.[0-9]*s")

echo -e "\n==================================\n"

echo "Test: nonlinear salt fingering"
OUTPUT=$(test/salt_fingering_nonlinear_test.sh)
STATUS=$?
if [ $STATUS ]; then
  echo "PASSED"
else
  echo "FAILED"
fi
echo "Time: " $(echo $OUTPUT | grep -oh "real\s[0-9]*m[0-9]*\.[0-9]*s\suser\s[0-9]*m[0-9]*\.[0-9]*s\ssys\s[0-9]*m[0-9]*\.[0-9]*s")
