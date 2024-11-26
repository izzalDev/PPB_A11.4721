#!/bin/bash

title=$(echo $(basename "$(pwd)") | awk '{print toupper($0)}')

generate() {
    cat << EOF > "$title.md"
---
title: "$title"
toc: true
toc-own-page: true
toc-title: "Daftar Isi"
titlepage: true
author: "$1 - $2"
header-includes:
  - \usepackage{caption}
  - \captionsetup[figure]{name=Screenshot, justification=centering, singlelinecheck=false}
---
EOF

    for project in $(find . -maxdepth 1 -type d ! -path .); do
        echo "# $(basename $project | tr 'a-z' 'A-Z')" >> "$title.md"

        if [ -d "$project/lib" ]; then
            for file in $(find $project/lib -type f -name "*.dart"); do
                echo "## ${file#$project/}" >> "$title.md"
                echo "\`\`\`dart" >> "$title.md"
                cat $file >> "$title.md"
                echo -e "\n\`\`\`" >> "$title.md"
            done
        else
            for file in $(find $project/frontend/lib -type f -name "*.dart"); do
                echo "## ${file#$project/}" >> "$title.md"
                echo "\`\`\`dart" >> "$title.md"
                cat $file >> "$title.md"
                echo -e "\n\`\`\`" >> "$title.md"
            done
            for file in $(find $project/backend/src -type f -name "*.ts"); do
                echo "## ${file#$project/}" >> "$title.md"
                echo "\`\`\`typescript" >> "$title.md"
                cat $file >> "$title.md"
                echo -e "\n\`\`\`" >> "$title.md"
            done
        fi
        echo "## screenshot" >> "$title.md"
        find "$project/screenshots" -name "*.png" -type f | while IFS= read -r image; do
            if [[ -f "$image" ]]; then
                magick "$image" -resize 300x "$image"
                echo "!["$(basename "${image%.png}")"]($image)" >> "$title.md"
                printf "\n\n" >> "$title.md"
            fi
        done
        echo "\clearpage" >> "$title.md"
    done
}

render() {
    pandoc "$title.md" -o "$title.pdf" \
    --template=$(git rev-parse --show-toplevel)/.github/template.latex \
    --pdf-engine=pdflatex \
    --dpi=300 \
    --listings --number-sections --embed-resources && rm -f "$title.md"
}

generate "$1" "$2" && render
