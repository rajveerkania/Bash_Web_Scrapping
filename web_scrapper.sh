#!/bin/bash

echo "TODAY'S NEWS:"

# Scrapping the data and storing it into the output.txt file
text="`curl -s "https://techcrunch.com/" | grep -A 1 'class="post-block__title__link"'`"

echo $text

