#!/bin/bash

title=$(echo $(basename "$(pwd)") | awk '{print toupper($0)}')

generate() {
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
        echo "## OUTPUT" >> "$title.md"
        for image in $(find $project/screenshots -type f); do
            if [[ -f "$image" ]]; then
                echo "![$(basename $image)]($image){ width=200px } \ \ " >> "$title.md"
            fi
        done
        echo "<div style=\"page-break-after: always\; visibility: hidden\">" >> "$title.md"
        echo "\pagebreak" >> "$title.md"
        echo "</div>" >> "$title.md"
        echo "" >> "$title.md"
    done
}

render() {
    pandoc "$title.md" -o "$title.pdf" --template eisvogel --listings --number-sections --embed-resources
}

case $1 in
    generate) generate ;;
    render) render ;;
    all) generate && render ;;
    *) echo "Usage: $0 {generate|render|all}" ;;
esac
