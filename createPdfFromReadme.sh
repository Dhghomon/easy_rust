#!/usr/bin/env bash

# Execute this script to generate a PDF version from the single Readme.md file present in this repository.
# Usage: ./createPdfFromReadme.sh

# -------------------- Utility Methods --------------------
# Check for binaries
function checkEnvironment(){
    type pandoc >/dev/null 2>&1 || { echo "Install 'pandoc' first (e.g. via 'brew install pandoc')." >&2 && exit 1 ; }
    type xelatex >/dev/null 2>&1 || { echo "Install 'xelatex' first" >&2 && exit 1 ; }
}

# Cleanup the src directory before starting
function cleanupBeforeStarting(){
    rm -rf ./latex
    mkdir latex
}


# Creates the summary from the generated chapters
function convertToLatex(){
    cd ./latex
    
    cp ../*.png .

    pandoc ../README.md -V geometry:margin=0.7in --standalone --from markdown --to latex > readme.tex
    echo "Generated readme.tex file."
    cp readme.tex easy_rust.tex

    xelatex --interaction=nonstopmode easy_rust.tex
    echo "Generated PDF file easy_rust.pdf"    

    cd ..
}



# -------------------- Steps to create the mdBook version --------------------
checkEnvironment
cleanupBeforeStarting
convertToLatex
