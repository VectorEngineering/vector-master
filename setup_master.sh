#!/bin/bash

# Add submodules
git submodule add https://github.com/VectorEngineering/vector-lead-management.git lead-management-platform
git submodule add https://github.com/VectorEngineering/vector-workflow-manager.git lead-sourcing-platform
git submodule add https://github.com/VectorEngineering/vector-leads-scraper.git lead-scraper-service
git submodule add https://github.com/VectorEngineering/resumable-upload-service.git resumable-upload-service
git submodule add https://github.com/VectorEngineering/vector-contract-management.git lead-contract-management-platform

# Initial commit
git add .
git commit -m "Add submodules for all Vector repositories"

# Create a script for daily updates
cat << EOF > update_submodules.sh
#!/bin/bash

# Update all submodules
git submodule update --remote

# Check if there are changes
if [[ -n $(git status -s) ]]; then
  # Commit and push changes
  git add .
  git commit -m "Daily update of submodules $(date +%Y-%m-%d)"
  git push origin main
else
  echo "No updates to submodules."
fi
EOF

# Make the update script executable
chmod +x update_submodules.sh

# Add the update script to the repository
git add update_submodules.sh
git commit -m "Add script for daily submodule updates"

# Push all changes to the remote repository
git push origin main

# Instructions for setting up a daily cron job
echo "To set up daily updates, add the following line to your crontab:"
echo "0 0 * * * cd /path/to/your/master-repo && ./update_submodules.sh"