#!/bin/bash

# Menemukan semua file pubspec.yaml
for project in $(find . -type f -name pubspec.yaml); do
    echo "Project ditemukan: $project"
    
    # Mencari file .dart di parent path project
    parent_dir=$(dirname "$project")
    echo $parent_dir
    parent2dir=$(dirname "$parent_dir")
    echo "parent2dir : $parent2dir"
    for file in $(find "$parent_dir" -maxdepth 1 -type f -name "*.dart"); do
        echo "File Dart di parent: $file"
    done

    # Mencari file .dart di dalam folder lib
    for file in $(find "$parent_dir/lib" -type f -name "*.dart"); do
        echo "File Dart di lib: $file"
    done
done
