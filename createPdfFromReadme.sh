#!/usr/bin/env bash

# Execute this script to generate a PDF version from the single Readme.md file present in this repository.
# Usage: ./createPdfFromReadme.sh

# -------------------- Utility Methods --------------------
# Check for binaries
function checkEnvironment(){
    type pandoc >/dev/null 2>&1 || { echo "Install 'pandoc' first (e.g. via 'brew install pandoc' or 'apt-get install pandoc')." >&2 && exit 1 ; }
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
    cp ../*.png .   # copy Easy_Rust_sample_image.png in the current folder in order to be found.

    # Step 1: run pandoc on README.md which generates the `.tex` file.

    # Commands used previously (didn't require metadata.yaml). Left here for reference...
    # pandoc ../README.md -V geometry:margin=0.7in -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=gray --standalone --from markdown --to latex > easy_rust.tex
    # pandoc ../README.md --standalone --from markdown --to latex > easy_rust.tex

    # generates `easy_rust.tex` in the current folder using the instructions given inside `../pdf_metadata.yaml`.
    pandoc ../README.md ../pdf_metadata.yaml -s -o easy_rust.tex # --toc    # The `toc` flag can be added or not depending on personal preferences.
                                                                            # If added, the `xelatex` command right below needs to be run twice (the first time.)
    echo "Generated easy_rust.tex file."


    # Step 2: run `xelatex` on the `.tex` file to geneate the PDF.
    xelatex --interaction=nonstopmode easy_rust.tex 
    # to generate the TOC you need to run this twice
    # xelatex --interaction=nonstopmode easy_rust.tex
    
    echo "Generated PDF file easy_rust.pdf"    
    cd ..
}



# -------------------- Steps to create the mdBook version --------------------
checkEnvironment
cleanupBeforeStarting
convertToLatex
