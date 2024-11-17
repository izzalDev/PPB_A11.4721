#!/bin/bash

title=$(echo $(basename "$(pwd)") | awk '{print toupper($0)}')
pandoc "$title.md" -o "$title.pdf" --template eisvogel --listings --number-sections