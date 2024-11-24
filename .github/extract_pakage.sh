#!/bin/bash

# Nama file LaTeX
FILE=$1

# Periksa apakah file diberikan
if [ -z "$FILE" ]; then
    echo "Usage: $0 <filename.latex>"
    exit 1
fi

# Periksa apakah file ada
if [ ! -f "$FILE" ]; then
    echo "File $FILE not found!"
    exit 1
fi

# Ekstrak semua package yang digunakan
grep '\\usepackage' "$FILE" | awk -F'[{}]' '{print $2}' > tex_deps.txt
