# fast-CICD-pipline-with-gitlab
## Concept Development
- 希望能夠做成一個手冊，讓大家都能夠輕鬆建立一個能夠根據自己的專案，建立自動執行CI/CD的環境
- hope to make an easy handbook, so everybody can make an auto CI/CD envirment easyly
## Knowledge from Lecture
* virtual machine
* CI/CD pipline 
* github
* gitlab
* docker
## Installation
  1. intall requriements <br>
  ``cat requirements.txt | xargs sudo aptitude install``
  2. GitLab 
      + create gitLab group
    ![圖片](https://user-images.githubusercontent.com/52521773/174013644-f574e8c7-fded-460f-94c1-3a784d705bd6.png)
      + create two project frontend-example and backend-example 
      ![圖片](https://user-images.githubusercontent.com/52521773/174013913-de5c92f7-35ec-46b9-ab1a-b4fab3138a32.png)
      + upload backend-example-ttest/ & frontend-example-test/ <br>
      ```
      // frontend
      git remote add origin https://gitlab.com/cicd-test-example/frontend-example.git
      git add .
      git commit -m "Initial commit"
      git push -u origin master
      // backend
      git init
      git remote add origin https://gitlab.com/cicd-test-example/backend-example.git
      git add .
      git commit -m "Initial commit"
      git push -u origin master
      ```
  3. GCE
    + login GCP(google cloud platform) and add a project
    ![圖片](https://user-images.githubusercontent.com/52521773/174016042-75b9397c-e75b-4102-9fab-80f33b553ac5.png)
    + create GCE virtual machine (pick ubunut and at least e2-medium)  
    ![圖片](https://user-images.githubusercontent.com/52521773/174016466-727dbcd6-dcf2-4dfa-a76c-217fe6d36e1d.png)
    + open http and https firewall
    ![圖片](https://user-images.githubusercontent.com/52521773/174018460-38f9a46a-5f17-4612-be2f-1edd6b763076.png)
    + ssh connect to GCE
    ![圖片](https://user-images.githubusercontent.com/52521773/174016840-cc1fb2a7-12f9-4df6-abc8-d0ca8c28b30f.png)
    + install docker in GCE kernel
        - Debian: https://docs.docker.com/engine/install/debian/
        - Ubuntu: https://docs.docker.com/engine/install/ubuntu/
    + add user to docker group (or you will needto use sudo -> not recommand)<br>
    ``` sudo usermod -aG docker ${USER}```
    + make ssh key <br>
    ``ssh-keygen -t rsa -C [USERNAME] ``
    + copy ``~/.ssh/id_rsa.pub`` to GCE  <br>
    ![圖片](https://user-images.githubusercontent.com/52521773/174017415-de85989b-9c4a-47e3-b9a1-8db4daefa9cd.png)
    + add variable as ``SSH_KEY_PRIVATE `` 
    ![圖片](https://user-images.githubusercontent.com/52521773/174017930-1598fa29-ac9c-462f-b724-87538c6568dd.png)
    + allow outer user to access GCE through firewall<br>
    ![圖片](https://user-images.githubusercontent.com/52521773/174018109-d75deb5a-544e-4808-af24-eebaf46d7ff5.png)
    ![圖片](https://user-images.githubusercontent.com/52521773/174018596-5c944536-3fcf-4556-8e06-90631045de03.png)
    + put clear-docker.sh in your GCE
  4.( test your docker file ) This step is not necessary, we have already made the Dockerfile 
    + test frontend with docker <br>
     ``` docker build -t frontend-example . ```
     ``` docker run -d --name frontend-example -p 80:80 frontend-example ```
    + test backend with docker <br>
     ``` docker build -t backend-example . ```
     ``` docker run -d --name backend-example -p 3000:3000 frontend-example ```   (localhost port:container port)
  5. before running GitLab
    + add three varible 
        - $DOCKER_REGISTRY_TOKEN : 登入Gitlab Docker Registry 所使用的 Token<br>
        [how to access gitLab with token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
        - $GCP_VM_HOST : GCE server ip (public ip)
        - $GCE_LOGIN_USER : GCE login user
        - $SSH_PRIVATE_KEY_GCE : ssh privte key from GCE
 
## Usage
  6. run Gitlab pipeline
    + run pipeline (frontend or backend)<br>
    ![圖片](https://user-images.githubusercontent.com/52521773/174021206-fefd2efd-f3e7-4eb8-be4a-8c4473f68317.png)
    + if succss you will be able to access your front or backend with your ``GCE PUBLIC IP:PORT``
    + success frontend example<br>
    ![圖片](https://user-images.githubusercontent.com/52521773/174021909-0d916606-1d7f-4890-8fbe-5651c0310d75.png)
    + success backend example<br>
    ![圖片](https://user-images.githubusercontent.com/52521773/174021964-dcc251da-f893-4b3c-be69-ad67dff4497b.png)

## Job Assignment
+ jamesliao89 yaml, gitLab, ppt
+ AlanjyHuang GCE, docker, readme
## References
- [GitLab ci/cd examples](https://docs.gitlab.com/ee/ci/examples/)
- [Create a Google GKE cluster - *GitLab.com*](https://docs.gitlab.com/ee/user/infrastructure/clusters/connect/new_gke_cluster.html)
- [GitLab CI/CD on Google Kubernetes Engine in 15 minutes](https://about.gitlab.com/blog/2020/03/27/gitlab-ci-on-google-kubernetes-engine/)
- [輕鬆建置](https://iamhongwei0417.medium.com/%E8%BC%95%E9%AC%86%E5%BB%BA%E7%BD%AE-gitlab-ci-cd-docker-gcp-compute-engine-react-nodejs-%E7%B6%B2%E9%A0%81%E5%89%8D%E5%BE%8C%E7%AB%AF%E8%87%AA%E5%8B%95%E5%8C%96%E6%95%B4%E5%90%88%E9%83%A8%E7%BD%B2-part-1-bcbf79e8c874)
- [how to access gitLab with token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
