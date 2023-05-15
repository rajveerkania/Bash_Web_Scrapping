#!/bin/bash


# Extracting the html file from the server
curl -s -o output.txt "https://techcrunch.com/"

# Extracting the lines containing having <a> and </a> with class="post-block__title__link"
grep -A 1 "post-block__title__link" output.txt | tail -n +6 | sed 's/^[[:space:]]*//' - > output2.txt

#Storing the data for inside a variable for the while loop

file_content=$(cat output2.txt)

#Initialising  arrays for iterating over titles and links
titles=()
links=()


# Storing every titles in titles array
while read -r line; do
  titles+=( "$line" )
done < <(cat output2.txt | grep '^[A-Z]' | sed 's/<\/a>//g')

#Storing every links in links array
while read -r line; do
	links+=( "$line" )
done < <(cat output2.txt | grep -oP '(?<=<a href=").*?(?="\s|$)')

#Header
echo -e "\n\nToday's news: \n\n"

#Prinitg the news
for i in "${!titles[@]}"; do

	echo -e "Title: ${titles[$i]}\nRead More: ${links[$i]}\n\n"
done

# Removing the temporary files
rm output.txt output2.txt
