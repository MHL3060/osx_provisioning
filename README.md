# osx_provisioning 

This easy the pain on how to provision a development environment for OS X.

## prerequsites:
 brew and git are installed.
 
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
Brewfile is the file contains a list of the software that will be installed by brew bundle

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
   
   
   
  
