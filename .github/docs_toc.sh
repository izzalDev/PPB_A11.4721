#!/bin/bash



# Membuat header untuk README.md
echo "# Dokumentasi Praktikum" > README.md
find . -type f -name "*.pdf" | while read -r file; do
    echo "- [$(basename "$file")]($file)" >> README.md
done
