#!/bin/bash

echo -e "Deploying updates to GitHub..."

# Remove previous build files
rm -rf public/*

# Build the project.
hugo -t mijnimal

# Go To Public folder
cd public
# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back
cd ..
