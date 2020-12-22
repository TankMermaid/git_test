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
    git branch --set-upstream   origin/dev dev

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
   
    # now switch into dir of git_tutorial and dev branch
    cd $HOME/git_tutorial
    git checkout dev
    # modifying something then push error
    git branch --set-upstream-to=origin/dev dev
    git pull # if merge conflict manually make corrections
    git push origin dev
    # ok it works


## Fork-PR mode
    # login another github account to fork this repos
    touch ~/.ssh/config
	# Host github
	# HostName github.com
    # PreferredAuthentications publickey
	# IdentityFile ~/.ssh/id_rsa_github

	# Host gitlab
	# HostName gitlab.mygitlab.com
    # PreferredAuthentications publickey
	# IdentityFile ~/.ssh/id_rsa_gitlab
    
    # modify .git/config url option with format usr.github.com
    # GUI to operate interactively

    # use extension to command-line git hub
    brew install hub
    hub --version
    git config --global hub.protocol https
   
    hub issue
    hub fork
    hub ci0status --verbose
    hub pull-request


   
