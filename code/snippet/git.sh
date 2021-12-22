# Initialization
git config --global user.name "Mr.Blue"
git config --global user.email "silverhugh.77@gmail.com"
git config --global core.editor "vim"

# Git alias
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.us 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ls 'log --oneline -20'

# Modify commits after <commit_id> (not included)
# 1. rebase
git rebase -i <commit_id>
# 2. change `pick` to `edit` before the commit that you want to modify
# 3. do some changes and commit
git add .
git commit --amend
# 4. move to next commit and back to step.3
git rebase --continue

# Modify author
git commit --amend --reset-author
git commit --amend --author="Mr.Blue <silverhugh.77@gmail.com>"

# Keep file in a Git repo, but don't track changes
git update-index --assume-unchanged <file>
# Undo
git update-index --no-assume-unchanged <file>

# Overwrite local branch
git fetch --all

# Merge Branch
git pull origin dev
git status
git diff HEAD xxx
git reset --hard origin/master

# Pull submodules
git submodule update --init --recursive  # First time
git submodule update --recursive

# Create Tag. Semantic Versioning: https://semver.org/
git tag -a <tag_name> [<commit_id>] -m <message>
# Remove tag
git tag -d <tag_name>
# Push a tag
git push origin <tag_name>
# Switch to tag
git checkout tags/<tag_name>

# git worktree: work with different branches simultaneously in different working directory
# https://git-scm.com/docs/git-worktree
git worktree add ../<new_branch_name>
git worktree list
git worktree prune
