#!/bin/bash
# Copyright (C) 2016-2020 TankMermaid
# File Name         : git_tutorial.sh
# License           : MIT
# Author            : Xiao-Ning Tank Zhang
# Email  <tanklovemermaid@gmail.com>
# Created Time      : Tue Dec 22 14:36:17 2020
# Last Modified Time: Tue Dec 22 14:36:17 2020
# Author            : Xiao-Ning Tank Zhang
# Email  <tanklovemermaid@gmail.com>
# Copyright (C) 2016-2020 TankMermaid
# File Name         : git_tutorial.sh
# License           : MIT
# Author            : Xiao-Ning Tank Zhang
# Email  <tanklovemermaid@gmail.com>
# Created Time      : Tue Dec 22 14:23:03 2020
# Last Modified Time: Tue Dec 22 14:23:03 2020
# Author            : Xiao-Ning Tank Zhang
# Email  <tanklovemermaid@gmail.com>
# Copyright (C) 2016-2020 TankMermaid
# File Name         : git_tutorial.sh
# License           : MIT
# Author            : Xiao-Ning Tank Zhang
# Email  <tanklovemermaid@gmail.com>
# Created Time      : Tue Dec 22 14:01:11 2020
# Last Modified Time: Tue Dec 22 14:01:11 2020
# Author            : Xiao-Ning Tank Zhang
# Email  <tanklovemermaid@gmail.com>
#########################################################################
# File Name: git_tutorial.sh
# Author: Xiao-Ning Tank Zhang
# Email: xnzhang@genetics.ac.cn
# Created Time: Tue 22 Dec 2020 10:55:57 AM CST
#########################################################################

## Install git and check version
	# git newest version and recompile in Ubuntu 18.04+
	git --version # if not 2.28+ then updating due to some change
    mkdir -p $HOME/software
    cd $HOME/software
    git clone https://github.com/git/git
    cd git
    autoconf
    ./configure --prefix=$HOME/software
    make && make install
    source ~/.bashrc 
    # source ~/.zshrc
    which git
    # /mnt/m1/xiaoning/software/bin/git
    git --version 
    # git version 2.30.0.rc1

## Configuration signature and default main branch
    # work for global mode repos
    git config --global init.defaultBranch main
    git config pull.rebase false
	git config --global user.name "bailab"
	git config --global user.email "bailab@gmail.com"

    # work only for local mode repos
    git config user.name "bailab"
	git config user.email "bailab@gmail.com"

    # check the config
	git config --ls

## Create a repos
### git init with bare repository then associated with github repos
    #1 in github new repos empty
	cd $HOME/git_tutorial
    touch README.md
    echo "# git_test" >> README.md
	git init  #generate .git dir to maintain a tree blob structure Be care with
    git add README.md
    git commit -m "first commit demo test"
    git branch -M main # -m|-M to rename branch compatible with the name master
    git remote add origin git@github.com:TankMermaid/git_test.git
    git push -u origin main # first push -u

    #2 if github new repos with README or License or .gitignore file
    git remote add origin git@github.com:TankMermaid/git_test.git
    git pull origin main --allow-unrelated-histories
	touch demo.py
    # vim demo.py
    git add .
    git commit -m "demo test to submit"
    git push -u origin main # first time add -u 

    #3 import code from svn or mercurial or TFS project(optional)
    ## refer official docs
	
### github new repos then git clone


### create
git checkout -b dev

### create in alternative 
git branch dev
git checkout dev

### view branches
git branch

touch readme.txt
vim readme.txt

git add readme.txt
git ci -m "dev branch test"


### switch to master from dev
git checkout master

### merge dev into master

git merge dev

## Fast-forward信息，Git告诉我们，这次合并是“快进模式”，也就是直接把master指向dev的当前提交，所以合并速度非常快。

当然，也不是每次合并都能Fast-forward，我们后面会讲其他方式的合并


### 合并完成后，就可以放心地删除dev分支了：
git branch -d dev 

		Git鼓励大量使用分支：

		查看分支：git branch

		创建分支：git branch <name>

		切换分支：git checkout <name>

		创建+切换分支：git checkout -b <name>

		合并某分支到当前分支：git merge <name>

		删除分支：git branch -d <name>


### collison

git checkout -b feature1

nano readme.txt
git add readme.md
git commit -m "and simple"

# Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
  Git还会自动提示我们当前master分支比远程的master分支要超前1个提交

vim readme.md
git add readme.md
git commit -m "& simple"


这种情况下，Git无法执行“快速合并”，只能试图把各自的修改合并起来，但这种合并就可能会有冲突

git merge feature1 

Auto-merging readme.md
CONFLICT (content): Merge conflict in readme.md
Automatic merge failed; fix conflicts and then commit the result.

Git告诉我们，readme.txt文件存在冲突，必须手动解决冲突后再提交


		Your branch is ahead of 'origin/master' by 2 commits.
		  (use "git push" to publish your local commits)
		You have unmerged paths.
		  (fix conflicts and run "git commit")

		Unmerged paths:
		  (use "git add <file>..." to mark resolution)

			both modified:   readme.md

git add readme.md 
git commit -m "conflict fixed"

git lg

git br -d feature1 

### not fast-forward method
git checkout -b dev
git merge --no-ff -m "merge with no-ff" dev

Merge made by the 'recursive' strategy.


git lg 

git status 
git stash


#### bug branch and stash 
修复bug时，我们会通过创建新的bug分支进行修复，然后合并，最后删除

当手头工作没有完成时，先把工作现场git stash一下，然后去修复bug，修复后，再git stash pop，回到工作现场


git add .

before we commit,we can 

git stash 
Saved working directory and index state WIP on dev: 18aba56 little modified
HEAD is now at 18aba56 little modified

git status

首先确定要在哪个分支上修复bug，假定需要在master分支上修复，就从master创建临时分支：
git checkout master
git checkout -b issue-101

vim issue101.py
git add issue101.py
git commit -m "fix bug 101"

git checkout master
git merge --no-ff -m "merged bug fix 101" issue-101
git br -d issue-101 


git checkout dev
git status

git stash list
stash@{0}: WIP on dev: 18aba56 little modified
一是用git stash apply恢复，但是恢复后，stash内容并不删除，你需要用git stash drop来删除；

另一种方式是用git stash pop，恢复的同时把stash内容也删了：

 git stash apply
 git stash drop 

git stash pop
 git stash list
git stash apply stash@{0}



#### feature branch
git checkout -b feature-vulcan

vim vulcan.py
git add vulcan.py

git status

开发一个新feature，最好新建一个分支；

如果要丢弃一个没有被合并过的分支，可以通过git branch -D <name>强行删除

### multiple cooperation

#### view remote 
git remote -v

当你从远程仓库克隆时，实际上Git自动把本地的master分支和远程的master分支对应起来了，并且，远程仓库的默认名称是origin
上面显示了可以抓取和推送的origin的地址。如果没有推送权限，就看不到push的地址
origin	https://github.com/TankMermaid/spike-in.git(fetch)
origin	https://github.com/TankMermaid/spike-in.git(push)

#### push branch

查看远程库信息，使用git remote -v；

本地新建的分支如果不推送到远程，对其他人就是不可见的；

从本地推送分支，使用git push origin branch-name，如果推送失败，先用git pull抓取远程的新提交；

在本地创建和远程分支对应的分支，使用git checkout -b branch-name origin/branch-name，本地和远程分支的名称最好一致；

建立本地分支和远程分支的关联，使用git branch --set-upstream branch-name origin/branch-name；

从远程抓取分支，使用git pull，如果有冲突，要先处理冲突。

##### rebase 

在上一节我们看到了，多人在同一个分支上协作时，很容易出现冲突。即使没有冲突，后push的童鞋不得不先pull，在本地合并，然后才能push成功



#### push empty reposity

git push -u origin master

git remote add origin git@server-name:path/repo-name.git；

先有本地库，后有远程库的时候，如何关联远程库

关联后，使用命令git push -u origin master第一次推送master分支的所有内容；

此后，每次本地提交后，只要有必要，就可以使用命令git push origin master推送最新修改；

假设我们从零开发，那么最好的方式是先创建远程库，然后，从远程库克隆。

首先，登陆GitHub，创建一个新的仓库，名字叫gitskills
要克隆一个仓库，首先必须知道仓库的地址，然后使用git clone命令克隆。

Git支持多种协议，包括https，但通过ssh支持的原生git协议速度最快



####
git checkout -- file

git reset HEAD <file>






#### alias

git config --global alias:br branch
git config --global alias:ci commit
git config --global alias:st status
git config --global alias:last log -1



#### tag 

### create 
git tag v1.0

### view
git tag

### tag history commit 
git lg  

### choose the commit hashcode and run
git tag v1.0 XX(hashcode)

### show detail of commit
git show v1.0

### tag name and additional message
git tag -a "v1.0" -m "Quantitative Profiling Method Version1.0 Released"

### push release version 
git push origin v1.0 

#####一次性推送全部尚未推送到远程的本地标签： 
git push origin --tags

#### 如果标签已经推送到远程，要删除远程标签就麻烦一点，先从本地删除：
git tag -d v0.9

#### 从远程删除。删除命令也是push，但是格式如下：
git push origin :refs/tags/v0.9

### brief summary

git push origin <tagname>可以推送一个本地标签；

git push origin --tags可以推送全部未推送过的本地标签；

git tag -d <tagname>可以删除一个本地标签；

git push origin :refs/tags/<tagname>可以删除一个远程标签



#### .ignore

git skills 

- .gitignore https://github.com/github/gitignore

git 4 status

- untrack 
- modified  (Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)
)
- Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits) nothing to commit, working directory clean


  有些时候，你想添加一个文件到Git，但发现添加不了，原因是这个文件被.gitignore忽略了
  如果你确实想添加该文件，可以用-f强制添加到Git：

$ git add -f App.class


或者你发现，可能是.gitignore写得有问题，需要找出来到底哪个规则写错了，可以用git check-ignore命令检查：

$ git check-ignore -v App.class
.gitignore:3:*.class    App.class

Git会告诉我们，.gitignore的第3行规则忽略了该文件，于是我们就可以知道应该修订哪个规则。



# git修改远程仓库地址
- git remote origin set-url [url]
- git remote rm origin
  git remote add origin [url]

- 直接修改config文件



# git uploading big file object

1. 将单个文件大于100M的文件不入库
git rm --cached giant_file
# Stage our giant file for removal, but leave it on disk

git commit --amend -CHEAD
# Amend the previous commit with your change
# Simply making a new commit won't work, as you need
# to remove the file from the unpushed history as well

git push
# Push our rewritten, smaller commit

git filter-branch -f \
	--prune-empty \
	--index-filter \
	'git rm -rf --cached --ignore-unmatch FrameworkFold/XXXFramework/xxx' \
	--tag-name-filter cat -- --all

git commit --amend -CHEAD

git push



2. 突破GitHub的限制，使用 git-lfs(Git Large File Storage) 支持单个文件超过100M







git rm -r --cached "文件夹的名称" 
git commit -m "更新log"
git push -u origin master

