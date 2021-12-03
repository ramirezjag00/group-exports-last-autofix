#!/bin/bash

if [[ ! -z $1 ]]; then
  echo "🗂  processing $1"
  for FILE in $1/*; do ./export_fix.sh $FILE; done
  echo -e "\\n $1 directory, DONE! 🚀"
else
  echo "❌  Missing argument: Forgot to pass directory to expand
usage: ./export_fix_all.sh ./sampleDir"
fi
