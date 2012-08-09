#!/bin/sh

cd /app

echo "Setting up SSH."
mkdir /app/.ssh
echo "$PRIV" > .ssh/id_rsa
echo "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
echo "Host heroku.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config

echo "Cloning repo."
git clone $GITHUB_URL
cd /app/presso

echo "Adding heroku url."
git remote add prod $HEROKU_PROD_REPO

echo "Pushing to heroku"
git checkout master # makes sure there's a master branch to push.
git push prod master

echo "Cleaning up..."
rm -Rf /app/presso
rm -Rf /app/.ssh/

exit 0

