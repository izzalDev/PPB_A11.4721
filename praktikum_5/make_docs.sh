#!/bin/bash

title=$(echo $(basename "$(pwd)") | awk '{print toupper($0)}')
cat << EOF > "$title.md"
---
title: "$title"
toc: true
toc-own-page: true
titlepage: true
subtitle: "Rizal Fadlullah - A11.2019.12070"
---
EOF

for project in $(find . -maxdepth 1 -type d ! -path .); do
    echo "# $(basename $project)" >> "$title.md"
    if [ -d "$project/lib" ]; then
        for file in $(find $project/lib -type f -name "*.dart"); do
            echo "## ${file#$project/}" >> "$title.md"
            echo "\`\`\`dart" >> "$title.md"
            cat $file >> "$title.md"
            echo "" >> "$title.md"
            echo "\`\`\`" >> "$title.md"
        done
    else
        for file in $(find $project/frontend/lib -type f -name "*.dart"); do
            echo "## ${file#$project/}" >> "$title.md"
            echo "\`\`\`dart" >> "$title.md"
            cat $file >> "$title.md"
            echo "" >> "$title.md"
            echo "\`\`\`" >> "$title.md"
        done
        for file in $(find $project/backend/src -type f -name "*.ts"); do
            echo "## ${file#$project/}" >> "$title.md"
            echo "\`\`\`typescript" >> "$title.md"
            cat $file >> "$title.md"
            echo "" >> "$title.md"
            echo "\`\`\`" >> "$title.md"
        done
    fi
    echo "## OUPUT" >> "$title.md"
done