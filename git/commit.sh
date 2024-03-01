#!/bin/bash

# Navigate to the parent workspace directory
cd /d/workspace

# Loop through each directory in the workspace
for dir in */; do
    # Check if the current directory is a Git repository
    if [ -d "$dir/.git" ]; then
        echo "Processing repository in $dir"

        # Navigate into the Git repository directory
        cd "$dir"

        # Add all changes to the staging area
        git add .

        # Commit changes with a default message
        git commit -m "Auto commit"

        # Push changes to the remote repository
        git push

        # Navigate back to the parent workspace directory
        cd ..
    fi
done
