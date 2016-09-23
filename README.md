# Dockerfiles for JBoss BPM Suite

## How to use this repository
For each version of the product, there is a branch containing a Dockerfile which will build a docker image for EAP.
Check out the branch you want, populate the correct installers (see below) and run the build from the root directory with

`docker build -t eap-base:VERSION .`

You may then launch a docker container from this image using 

`docker run eap-base:VERSION`

- The default username/password for the eap admin console is admin/Pass@123

## Repository structure
- **installers**
    This directory is where you put the installers downloaded from Red Hat. See the README there for details.
- **support**
    This directory is where the auto configuration files for the installers are kept. Change the passwords in *.xml.variables to customize the passwords.
- **default_profiles**
    This directory contains the profiles available by default.
