# Project 16: Cloud State with Terraform

This project demontrates the use of Terraform as an IaC tool to deploy a WebApp on AWS cloud. Terraform is smart enough to reduce the time consuming activity of manually configuring the cloud services to make an Infrastructure up and running, reduce considerably human errors that could sneak in during confifuration, takes very little time to update the infrastructure and has a centralised point of configuration for the management of the infrastrutuce and state maintenance. I used terraform to deploy the different services that builds up the webApp. In this project, I used code to:
 - Setup terraform with backend in S3, enabling teams to work collaboratively
 - Setup a secure and highly available VPC
 - Provision a Beanstalk environment
 - Provision backend services( RDS, Elasticache, AmazonMQ)

## Prereqs
- AWS CLI with Administrator credentials configured
- Terraform installed on local machine
- Maven 3.6.3, java-11-openjdk installed

## Architecture
![](architecture)

## Steps
1. Clone source code
    ```
    git clone https://github.com/Ndzenyuy/Project_16-Terraform-AWS.git
    ```
2. Run the cloned code in the command line
    ```
    terraform init
    terraform validate
    terraform apply
    ```
    Elastic beanstalk is deployed with test artifact
    ![](deployment with test artifact)

3. Copy enpoints of mysql database, memcached and AmazonMq(created by terraform) 
    The copied endpoints will look similar to:
    ```
    mysql-url: terraform-20230929165013608400000003.czohtaa5mjpd.us-east-2.rds.amazonaws.com
    memcached-url: vprofile-cache.jxfiuk.cfg.use2.cache.amazonaws.com
    amazonMQ: b-88fd67e0-80c5-49a4-bd1d-dd6b6987a565-1.mq.us-east-2.amazonaws.com
    ```
    Similar copied pages;
    ![](mysql-urlpage)
    ![](memcached url)
    ![](rabbitmq-url)

4. Clone and build source code
    ```
    git clone https://github.com/Ndzenyuy/vprofile-project.git
    git checkout vp-rem
    nano src/main/resources/application.properties
    ```
    Change the contents of this file to look like this
    ```
    #JDBC Configutation for Database Connection
    jdbc.driverClassName=com.mysql.jdbc.Driver
    jdbc.url=jdbc:mysql://<copied_mysql_url>:3306/accounts?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
    jdbc.username=admin
    jdbc.password=admin123

    #Memcached Configuration For Active and StandBy Host
    ##For Active Host
    memcached.active.host=<copied_memcached_url>
    memcached.active.port=11211
    #For StandBy Host
    memcached.standBy.host=127.0.0.2
    memcached.standBy.port=11211

    #RabbitMq Configuration
    rabbitmq.address=<copied_rmq_url>
    rabbitmq.port=5671
    rabbitmq.username=rabbit
    rabbitmq.password=admin@rmq123

    #Elasticesearch Configuration
    elasticsearch.host =192.168.1.85
    elasticsearch.port =9300
    elasticsearch.cluster=vprofile
    elasticsearch.node=vprofilenode
    ```
    Save file and quit. Now run
    ```
    mvn build
    ```
    This will build the artifact locally, ready to be deployed to elastic beanstalk
    ![](mvn build sucessful)

5. Upload Artifact to Beanstalk \
    On beanstalk environment in the console -> upload and deploy -> choose artifact -> Deploy
    ![](updating elastic beanstalk)

6. Check url of beanstalk environment to confirm deployment
    ![](Loginpage)
    ![](successful login)
    ![]()
    ![]()
    ![]()

