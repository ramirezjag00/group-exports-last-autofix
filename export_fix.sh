#!/bin/bash

current_file="$(cat $1)"
needle_export_named="export const"
needle_export_default_anonymous="export default () =>"
needle_export_default_aggregated="export { default as"
needle_export_default_object="export default {"
export_named_list=""
export_default=""
export_default_aggregate=""
finished="✅  $1 DONE!"
file_name=$(echo ${1##*/})

echo -e "\\n⚙️  processing $1"

if [[ $file_name == *".js"* ]] || [[ $file_name == *".jsx"* ]] || [[ $file_name == *".ts"* ]] || [[ $file_name == *".tsx"* ]]; then
  while read -r line; do
    if [[ ${line} == *"$needle_export_default_anonymous"* ]] || [[ ${line} == *"$needle_export_default_object"* ]]; then
      if [[ $1 == *"/"* ]]; then
        export_default=$(echo ${1##*/} | cut -d "." -f 1)
      else
        export_default=$(echo $1 | cut -d "." -f 1)
      fi
    elif [[ $line == *"$needle_export_default_aggregated"* ]]; then
      parsed_export=$(echo "$line" | cut -d " " -f 5)
      reshaped_import="import $parsed_export $(echo ${line##*\}})"
      sanitized_code=$(cat $1 | sed "s~${line}~${reshaped_import}~g")
      echo -e "$sanitized_code\\n" > $1
      export_default_aggregate="$export_default_aggregate $parsed_export,"
    elif [[ $line == *"$needle_export_named"* ]]; then
      parsed_export=$(echo "$line" | cut -d " " -f 3)
      export_named_list="$export_named_list $parsed_export,"
    fi
  done < <(grep "export" <<< "$current_file")

  if [[ ! -z "$export_default" ]] && [[ ! -z "$export_named_list" ]]; then
    bottom_export="export { $export_default as default, $export_named_list };"
    sanitized_code=$(cat $1 | sed "s/export default/const $export_default =/g" | sed "s/export //g")
    echo -e "$sanitized_code\\n" > $1
    echo $bottom_export >> $1
    echo $finished
  elif [[ ! -z "$export_default" ]] && [[ ! -z "$export_default_aggregate" ]]; then
    bottom_export="export { $export_default as default, $export_default_aggregate };"
    sanitized_code=$(cat $1 | sed "s/export default/const $export_default =/g")
    echo -e "$sanitized_code\\n" > $1
    echo $bottom_export >> $1
    echo $finished
  elif [[ ! -z "$export_named_list" ]] && [[ ! -z "$export_default_aggregate" ]]; then
    bottom_export="export {$export_named_list $export_default_aggregate };"
    sanitized_code=$(cat $1 | sed "s/export //g")
    echo -e "$sanitized_code\\n" > $1
    echo "$bottom_export" >> $1
    echo $finished
  elif [ ! -z "$export_default" ]; then
    bottom_export="export default $export_default;"
    sanitized_code=$(cat $1 | sed "s/export default/const $export_default =/g")
    echo -e "$sanitized_code\\n" > $1
    echo $bottom_export >> $1
    echo $finished
  elif [ ! -z "$export_default_aggregate" ]; then
    bottom_export="export {$export_default_aggregate };"
    echo $bottom_export >> $1
    echo $finished
  elif [ ! -z "$export_named_list" ]; then
    bottom_export="export {$export_named_list };"
    sanitized_code=$(cat $1 | sed "s/export //g")
    echo -e "$sanitized_code\\n" > $1
    echo "$bottom_export" >> $1
    echo $finished
  else
    echo -e "\\n⚠️  $1 is already sanitized ⚠️\\n"
  fi
else
  echo -e "\\n⚠️  $1 is not a .js,.jsx,.ts,.tsx file ⚠️\\n"
fi
