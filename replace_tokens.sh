#!/bin/bash

html_file="tokens.html"

declare -A tokens

#for file in $(find harjoitukset/build -name "*.html"); do
for file in $(find harjoitukset/build -name "*.html" | sort); do
    if grep -q -E '<button[^>]*class="[^"]*token[^"]*"' "$file"; then
        title=$(grep -m 1 "<title>.*<\/title>" "$file" | sed -E 's/<\/?title>//g')
        answerToken=$(node extract-token.js "$title")

        file_name=$(basename "$file")
        exercise_number=${file_name%.html}
        exercise_number=${exercise_number##*_}
        tokens["HARJOITUS $exercise_number"]=$answerToken
    fi
done

> "$html_file"

for key in "${!tokens[@]}"; do
    value="${tokens[$key]}"
    echo "<p>$key: $value</p>" >> "$html_file"
done