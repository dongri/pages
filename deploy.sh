#!/bin/bash

echo -e "Deploying updates to GitHub..."

git pull origin master

# Build the project.
hugo

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
# git subtree push --prefix=public git@github.com:dongri/dongri.github.io.git master

# force push
#git push git@github.com:dongri/dongri.github.io.git `git subtree split --prefix public master`:master --force

# New Deploy
cd public
git add -A
# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"
git push -f origin master
