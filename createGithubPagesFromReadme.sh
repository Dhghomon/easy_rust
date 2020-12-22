#!/usr/bin/env bash

# A modified version of createBookFromReadme.sh for Github Pages
# Usage: ./createGithunPagesFromReadme.sh

# -------------------- Utility Methods --------------------
# Check for binaries
function checkEnvironment(){
    type gcsplit >/dev/null 2>&1 || { echo "Install 'gcsplit' first (e.g. via 'brew install coreutils')." >&2 && exit 1 ; }
}

# Cleanup the src directory before starting
function cleanupBeforeStarting(){
    rm -rf ./src
    mkdir src
}

# Splits the Readme.md file based on the header in markdown and creates chapters
# Note:
#   Get gcsplit via homebrew on mac: brew install coreutils
function splitIntoChapters(){
    gcsplit --prefix='Chapter_' --suffix-format='%d.md' --elide-empty-files README.md '/^## /' '{*}' -q
}

# Moves generated chapters into src directory
function moveChaptersToSrcDir(){
    for f in Chapter_*.md; do 
        mv $f src/$f
    done
}

# Creates the summary from the generated chapters
function createSummary(){
    cd ./src
    touch SUMMARY.md
    echo '# Summary' > SUMMARY.md
    echo "" >> SUMMARY.md
    for f in $(ls -tr | grep Chapter_); do
        # Get the first line of the file
        local firstLine=$(sed -n '1p' $f)
        local cleanTitle=$(echo $firstLine | cut -c 3-)
        echo "- [$cleanTitle](./$f)" >> SUMMARY.md;
    done
    cd ..
}

# -------------------- Steps to generate separate Markdown chapters --------------------
checkEnvironment
cleanupBeforeStarting
splitIntoChapters
moveChaptersToSrcDir
createSummary