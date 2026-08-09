# Script to push the Scalability Expert skill to GitHub
# 1. Create a repository on GitHub (e.g. https://github.com/SavianAlexander/scalability-expert)
# 2. Run this script!

$githubRepoUrl = Read-Host -Prompt "Paste your GitHub repository URL here (e.g. https://github.com/SavianAlexander/scalability-expert.git)"

Write-Host "Pushing to $githubRepoUrl..."
git remote add origin $githubRepoUrl
git branch -M main
git push -u origin main

Write-Host "Done! Your skill is uploaded to GitHub."
Pause
