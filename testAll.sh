#!/bin/bash

OK=0

function displaytime {
  local T=$(($1/1000))
  local H=$((T/60/60))
  local M=$((T/60%60))
  local S=$((T%60))
  local MS=$(($1%1000))
  (( $H > 0 )) && printf '%dh ' $H
  (( $M > 0 || $H > 0 )) && printf '%dm ' $M
  (( $S > 0 || $M > 0 || $H > 0 )) && printf '%d.%03ds' $S $MS
  (( $H == 0 && $M == 0 && $S == 0 )) && printf '%dms\n' $MS
}

function executeTests {
  file=$1
  puzzle=${file:0:-3}
  day=${puzzle:0:-2}
  part=${puzzle: -1}
  for test in $(ls input/${puzzle}\.test*); do
    if [[ "$test" =~ ^.*=(.*)$ ]]; then
      expected=${BASH_REMATCH[1]}
      result=$(runhaskell ${file} ${test})
      if [ "$result" != "$expected" ]; then
        printf "[ \033[0;31mTEST  FAILED\033[0m ] Test %s returned %s instead of %s" "$test" "$result" "$expected"
        return 1
      fi
    fi
  done
  printf "[ \033[0;32mTEST  PASSED\033[0m ] "
}

function printPuzzle {
  file=$1
  puzzle=${file:0:-3}
  day=${puzzle:0:-2}
  part=${puzzle: -1}
  printf "puzzle day %2s part %s: " $day $part
  startTime=$(date +%s%0N)
  executeTests $file || OK=1
  endTime=$(date +%s%0N)
  duration=$(( ($endTime-$startTime)/1000000 ))
  echo " ($(displaytime $duration))"  
}

function listPuzzles {
  if [ -z "$1" ]; then
    ls *.hs | grep -v debug | grep -v common | grep -v \'
  else
    ls $1*.hs | grep -v debug | grep -v common
  fi
}

for puzzle in $(listPuzzles "$1" | sort -V); do
  printPuzzle $puzzle
done

exit $OK
