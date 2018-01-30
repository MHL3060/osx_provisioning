# osx_provisioning 

To provision a development environment on OS X. This is focus on dev environment.

## prerequsites:
 brew and git are installed.
 To install brew
  ```
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

 ```
## installation.
```
  mkdir ~/.bash
  cd ~/.bash
  git clone https://github.com/MHL3060/osx_provisioning.git
  brew bundle
```  
add the following line to your ~/.bash_profile
    
  ```
    source ~/.bash/bash_profile
  ```
 run 
 ```
 source ~/.bash_profile
 ```
## Add/Remove/View software packages
Brewfile is the file contains a list of the software that will be installed by brew bundle
you can use your favorite text editor to view this file. 
if you need to remove a package, just delete the line that defines the package.

use the following to generate a new Brewbundle file
```
brew bundle dump
```

## random notes
 if you have a specific folder for all your projects, you can run the following command 
 ```
 echo "export PROJECT_ROOT=${project_folder}" > ~/.bash/bash_profile
 . ~/.bash_profile
 ```
  here is the command
   p -- to list all the projects inside the ${project_folder}
   p project -- cd to ${PROJECT_ROOT}/project
   
   
   
  
