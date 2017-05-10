FROM node:7
MAINTAINER Premysl Maly premma@gmail.com
WORKDIR /tmp
ENV PATH=$PATH:/opt/google/chrome
RUN mkdir /protractor && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    sh -c 'echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list.d/java8.list'
RUN apt-get update && \
    apt-get install -y xvfb wget google-chrome-stable && \
    apt-get install -y -t jessie-backports  openjdk-8-jre-headless ca-certificates-java openjdk-8-jre && \
    npm install -g protractor mocha jasmine && \
    apt-get clean && \
    webdriver-manager clean \
    webdriver-manager update --chrome
ADD protractor.sh /protractor.sh
RUN chmod a+x /protractor.sh
RUN npm install -g protractor-jasmine2-screenshot-reporter --save-dev
VOLUME /protractor
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]

