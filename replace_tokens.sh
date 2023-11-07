#!/bin/bash

md_file="tokens.md"

> "$md_file"

echo '```' >> "$md_file"

for file in $(find harjoitukset/build -name "*.html" | sort); do
    if grep -q -E '<button[^>]*class="[^"]*token[^"]*"' "$file"; then
        title=$(grep -m 1 "<title>.*<\/title>" "$file" | sed -E 's/<\/?title>//g')
        answerToken=$(node extract-token.js "$title")
        file_name=$(basename "$file")
        exercise_number=${file_name%.html}
        exercise_number=${exercise_number##*_}

        echo "HARJOITUS $exercise_number: $answerToken" >> "$md_file"
    fi
done

echo '```' >> "$md_file"
