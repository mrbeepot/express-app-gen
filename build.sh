#!/bin/bash

# Usage
if [ "$1" = "-h" ]
then
    echo "USAGE:"
    echo -e "\tbuild.sh [app-name] [ts]"
    echo -e "\tArgs:"
    echo -e "\tOptional: If you pass \"ts\" as the second argument, script will install TypeScript related dependencies."
    exit 1
fi

# Read the app name
appName=$1

# Check if typescript is required
if [ "$2" = "ts" ]
then
    isTypescript=true
else
    isTypescript=false
fi

# Create directory if it does not exist
mkdir -p "$appName"

# change directory to that folder
cd "$appName"

# Create package.json file with default settings.
yarn init --yes

# Install express.js
yarn add express

# Install nodemon
yarn add -D nodemon

# Install typescript related dependencies if required.
if [ $isTypescript = true ]
then
    yarn add -D @types/node @types/express nodemon typescript
fi

# Create a .editorconfig
touch .editorconfig
cat >.editorconfig <<EOL
root = true

[*]
trim_trailing_whitespace = true
insert_final_newline = true
end_of_line = lf

[*.yml]
indent_style = space
indent_size = 2
tab_width = 2# This is actually a node library. Source code: https://github.com/benawad/tsconfig.json
    npx tsconfig.json
[*.{js,ts,json,html,css}]
indent_style = tab
indent_size = 4
tab_width = 4

EOL

# Create a .env

touch .env
cat >.env <<EOL
BROWSER=none
EOL

# Initialize a git repo
git init

# Check if jq is installed or not

if ! command -v jq &> /dev/null
then
    echo "jq is not installed."
    echo "To install it, refer to: https://stedolan.github.io/jq/download/"
    exit 1
fi

# Modify package.json to add scripts I want
if [ $isTypescript = true ]
then

    jq '.scripts = {"devStart": "nodemon dist/index.js", "devWatch": "tsc -w"}' package.json > p.json
else
    jq '.scripts = {"devStart": "nodemon index.js"}' package.json > p.json
fi

rm package.json
mv ./p.json package.json

# Create a tsconfig.json
if [ $isTypescript = true ]
then
    # This is actually a node library. Source code: https://github.com/benawad/tsconfig.json
    npx tsconfig.json
fi
