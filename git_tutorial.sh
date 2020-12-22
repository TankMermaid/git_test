#!/bin/bash
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
	
### github new repos then git clone(strongly recommended)
    # github create a repos with init file such as readme,licence and .gitignore
    # then clone into local repos
    git clone git@github.com:TankMermaid/git_test.git



## Branching and Merging
### create branch
    git branch          ## list all branch
    git branch test     ## create branch named test
    git checkout test   ## switch into branch test
    git checkout -b dev ## create and switch one step

    git checkout main
    git merge dev

    ## if merge conflict manually correc or git mergetools


## multiple cooperation

### view remote 
    git remote -v
    # if you have no access to push only fetch info


### push branch to remote
    git push origin dev
    # new branch and same name with remote branch recommended
    git checkout -b dev  origin/dev
    # mapping local and remote branch
    git branch --set-upstream dev  origin/dev

    # remote push fail, first git pull, if conflict then manually correct it

### simulate multiple colaborating style
    mkdir -p $HOME/git_tutorial_co
    cd $HOME/git_tutorial_co
    git clone git@github.com:TankMermaid/git_test.git

    git branch 
    # create local dev and mapping with remote
    git checkout -b dev origin/dev
    git push origin dev

    git pull origin dev 

    
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

