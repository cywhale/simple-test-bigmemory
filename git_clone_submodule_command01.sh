# git submodule 
# refer to https://github.blog/2016-02-01-working-with-submodules/ 
git clone --recursive --progress -- https://github.com/cywhale/openocean.git D:\Gits\openocean
# D:\Gits\openocean
git submodule add https://github.com/jdomingu/ThreeGeoJSON ThreeGeoJSON
git commit -m "ThreeGeoJSON submodule"
git submodule update --init --recursive
git push origin master:master --progress
# git fetch --progress --prune origin

# remove a submodule if give wrong subdirectory
# remove Your_submodule from .gitmodules for 3-lines description
# remove this submodule in .git/config 
# git rm --cached Your_submodule cause error: fatal: Please, stage your changes to .gitmodules or stash them to proceed
git add .gitmodules
git rm --cached Your_local_path_to_submodule/Your_submodule
# then delete or mv this subdirectory of submodule

# Similar to git a local folder to a repo subdirectory after git clone 
# But must put your local folder (copy/move) under the directory where you git clone
# cd git_clone_dir/your_local_folder
git add . # after that can use git add -A
git commit -m "git a local folder to a repo subdir"
git push origin master

# Cance/withdraw from git commit but not git push yet
git reset HEAD~1 --soft

# A withdraw from git commit should be careful by using git reset HEAD^, that delete your local file if you commit local edit
# Recover it:
git reflog # to see which commit you want to recover
## 42a259f HEAD@{2}: reset: moving to HEAD^
## 6829620 HEAD@{3}: commit: new commit
git reset --hard 682920 ## save local edit by --hard

# Condition
# git push rejected: Updates were rejected because the remote contains work that you do not have locally.
git pull --rebase 
# error: Cannot pull with rebase: You have unstaged changes.
git status
#On branch master
#Your branch is ahead of 'origin/master' by 1 commit.
#  (use "git push" to publish your local commits)
#Changes not staged for commit:
#  (use "git add/rm <file>..." to update what will be committed)
#  (use "git checkout -- <file>..." to discard changes in working directory)
#	deleted:    ../YourDir/YourFile
git checkout -- ../YourDir/YourFile
# then git pull,.. git push...

# But if you have two workspaces to modify the same repository, and get
# error: Cannot pull with rebase: You have unstaged changes.
# You still want to rebase, but not drop your changes (in another workspace)
git fetch
# 720a32f..e578c68  master     -> origin/master
git rebase --autostash FETCH_HEAD
# Created autostash: 3e4d3a0
# HEAD is now at 720a32f read https cert in async & try auto-push
# First, rewinding head to replay your work on top of it...
# Fast-forwarded master to FETCH_HEAD.
# Applying autostash resulted in conflicts.
# Your changes are safe in the stash.
# You can run "git stash pop" or "git stash drop" at any time.

# Sometimes file got unmerged make git rebase --autostash fail such as 
# xxfile: needs merge
# xxfile: unmerged (72902cbc64e51cda676da55130ca3e5c79951e59)
# xxfile: unmerged (c1087b840ada55f0ff6fa896bcc502043a71fc8b)
# Cannot save the current index state
git status
# follow git suggestion, to handle each unmerged file, and then save your stash handle
git stash save "temp1"
# Saved working directory and index state On master: temp1
git stash list
# stash@{0}: On master: temp1
# stash@{1}: autostash
git pull
# .................................... 
# Already up to date.
git stash pop stash@{0}
# On branch master
# Your branch is up to date with 'origin/master'.
git rebase --autostash FETCH_HEAD
# Created autostash: 6eeb93f
# Current branch master is up to date.
# Applied autostash................... Done

