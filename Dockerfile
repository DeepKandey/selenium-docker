FROM openjdk:8u212-jre-alpine3.9

RUN apk add curl jq

#workspace
WORKDIR /usr/share/udemy

#ADD .jar under target from host into this image
ADD target/selenium-docker.jar          selenium-docker.jar
ADD target/selenium-docker-tests.jar    selenium-docker-tests.jar
ADD target/libs                         libs

#in case of any other dependency like .csv / .json / .xls
#please add that as well

#ADD suite files
ADD book-flight-module.xml              book-flight-module.xml
ADD search-module.xml                   search-module.xml

#ADD health check script
RUN wget https://s3.amazonaws.com/selenium-docker/healthcheck/healthcheck.sh

#BROWSER
#HUB_HOST
#MODULE

ENTRYPOINT sh healthcheck.sh
#ENTRYPOINT java -cp selenium-docker.jar:selenium-docker-tests.jar:libs/* -DHUB_HOST=$HUB_HOST -DBROWSER=$BROWSER org.testng.TestNG $MODULE
