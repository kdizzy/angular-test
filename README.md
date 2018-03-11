# Angular Docker build

This project demonstrate the simplistic approach in deploying angular project into docker container. 

## Docker deployment
Docker builds the image in multi stage.

Stage 1: Using node image, install pre-requisites (npm), build the source code
Stage 2: Using nginx image, only use built files from State 1 for deployment release.

Using multi stage build keeps the dockerfile simple since it has all every stage in a single file. It also reduces the size of resultant image by only using the required/dependent files from previous stage image.

It doesn't necessarily require to build the entire Dockerfile including every stage. You can specify a target build stage. 


## How to build

docker build -t angular-test:v1


## How to test image is working

docker run -p 80:80 angular-test:v1

This should start up docker container with nginx running with angular files as the source.

Open browser and load url
http://localhost

This should load angular index.html page with list of views.

## CICD
For CICD, I have adopted Jenkins and Kubernetes. I have also used Google container registry for images.
Every time a job is run, it will create a pod in K8 cluster as jenins slave and perform the tasks within.


Setup a pipeline in jenins with webhook to github repo. For every commit in master branch, Jenkins file will get executed and perform following tasks

1) Check-out code from git
2) build docker image
3) publish docker image to google resgistry with proper tagging
4) deploy newly built image to K8 containers



## Caveats

I have few issues deploying angular-seed project direct of github. I was running into all sort of @angular/cli and typescript versions incompatibility issues.

So I had to tweak the project a little bit to make it work with docker. 


