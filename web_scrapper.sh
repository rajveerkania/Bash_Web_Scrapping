#!/bin/bash


# Extracting the html file from the server
curl -s -o output.txt "https://techcrunch.com/"

# Extracting the lines containing having <a> and </a> with class="post-block__title__link"
grep -A 1 "post-block__title__link" output.txt | tail -n +6 | sed 's/^[[:space:]]*//' - > output2.txt

#Storing the data for inside a variable for the while loop
file_content=$(cat output2.txt)

#Initialising an array for iterating over title
array=()
while read -r line; do
  array+=( "$line" )
done < <(cat output2.txt | grep '^[A-Z]' | sed 's/<\/a>//g')

#Flag variable for iterating in the while loop
flag=0

while IFS='<' read -r line;
do
	echo "Title: ${array[$flag]}"
	flag=$((flag + 1))
  
  if [[ $line =~ href=\"(.*)\".* ]]; then
    link=$(echo "${BASH_REMATCH[1]}" | sed 's/" class="post-block__title__link//g')
    echo "Link: $link"
  fi
done <<< "$file_content"


rm output.txt output2.txt output3.txt
