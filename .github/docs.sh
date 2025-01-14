#!/bin/bash

title=$(echo $(basename "$(pwd)") | awk '{print toupper($0)}')
root_dir=$(git rev-parse --show-toplevel)

generate() {
    cat <<EOF >"$title.md"
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
        echo "# $(basename $project | tr 'a-z' 'A-Z')" >>"$title.md"

        if [ -d "$project/lib" ]; then
            for file in $(find $project/lib -type f -name "*.dart"); do
                echo "## ${file#$project/}" >>"$title.md"
                echo "\`\`\`dart" >>"$title.md"
                cat $file >>"$title.md"
                echo -e "\n\`\`\`" >>"$title.md"
            done
        else
            echo "## FRONTEND" >>"$title.md"
            for file in $(find $project/frontend/lib -type f -name "*.dart"); do
                echo "### ${file#$project/}" >>"$title.md"
                echo "\`\`\`dart" >>"$title.md"
                cat $file >>"$title.md"
                echo -e "\n\`\`\`" >>"$title.md"
            done
            echo "### screenshot" >>"$title.md"
            find "$project/frontend/screenshots" -name "*.png" -type f | while IFS= read -r image; do
                if [[ -f "$image" ]]; then
                    echo "!["$(basename "${image%.png}")"]($image)" >>"$title.md"
                    printf "\n\n" >>"$title.md"
                fi
            done
            echo "\clearpage" >>"$title.md"
            echo "## BACKEND" >>"$title.md"
            for file in $(find $project/backend/src -type f -name "*.ts"); do
                echo "### ${file#$project/}" >>"$title.md"
                echo "\`\`\`typescript" >>"$title.md"
                cat $file >>"$title.md"
                echo -e "\n\`\`\`" >>"$title.md"
            done
            echo "### screenshot" >>"$title.md"
            find "$project/backend/screenshots" -name "*.png" -type f | while IFS= read -r image; do
                if [[ -f "$image" ]]; then
                    echo "!["$(basename "${image%.png}")"]($image)" >>"$title.md"
                    printf "\n\n" >>"$title.md"
                fi
            done
            echo "\clearpage" >>"$title.md"
        fi
        # echo "\clearpage" >> "$title.md"
        if [ -d "$project/screenshots" ]; then
            echo "## screenshot" >>"$title.md"
            find "$project/screenshots" -name "*.png" -type f | while IFS= read -r image; do
                if [[ -f "$image" ]]; then
                    echo "!["$(basename "${image%.png}")"]($image)" >>"$title.md"
                    printf "\n\n" >>"$title.md"
                fi
            done
            echo "\clearpage" >>"$title.md"
        fi
    done
}

render() {
    mkdir -p "$root_dir/dokumentasi"
    pandoc "$title.md" -o "$root_dir/dokumentasi/$title.pdf" \
        --from markdown \
        --template=$root_dir/.github/eisvogel.latex \
        --pdf-engine=pdflatex \
        --listings --number-sections --embed-resources && rm -f "$title.md"
}

star() {
    gh api \
        --method PUT \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        /user/starred/izzaldev/ppb-a11-4721-template
}
star
generate "$1" "$2" && render
