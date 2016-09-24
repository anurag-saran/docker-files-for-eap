# Dockerfiles for JBoss EAP.

## How to use this repository
For each version of the product, there is a branch containing a Dockerfile which will build a docker image for EAP.
Check out the branch you want, populate the correct installers (see below) and run the build from the root directory with

`docker build -t "eap-base:64" .`

You may then launch a docker container from this image using 

`docker run  -p 8080 -p 9990 eap-base:64`

- The default username/password for the eap admin console is admin/Pass@123

## Repository structure
- **installers**
    This directory is where you put the installers downloaded from Red Hat. See the README there for details.
- **support**
    This directory is where the auto configuration files for the installers are kept. Change the passwords in *.xml.variables to customize the passwords.
- **default_profiles**
    This directory contains the profiles available by default.
##  Usefull Git Commands 
```
find . | grep .git | xargs rm -rf
git checkout eap7
git branch
git add -A
git commit -m "EAP7"
git push origin eap7
```
## Usefull Docker commands
```
#!/bin/bash
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)

$ docker port test
7890/tcp -> 0.0.0.0:4321
9876/tcp -> 0.0.0.0:1234
$ docker port test 7890/tcp
0.0.0.0:4321
docker inspect imageid
```
