#!/bin/bash

curl -s -o output.txt "https://techcrunch.com/"

grep -A 1 "post-block__title__link" output.txt | tail -n +6 > output2.txt

file_content=$(cat output2.txt)

while IFS='<' read -r line;
do
  text=$(sed -n 's/.*<a href="[^>]*>\([^<]*\)<\/a>.*/\1/p' output2.txt)
  echo "$text"
  
  if [[ $line =~ href=\"(.*)\".* ]]; then
    link=$(echo "${BASH_REMATCH[1]}" | sed 's/" class="post-block__title__link//g')
    echo "Link: $link"
  fi
done <<< "$file_content"


rm output.txt output2.txt
