FROM node:7
MAINTAINER Premysl Maly premma@gmail.com
WORKDIR /tmp
ENV PATH=$PATH:/opt/google/chrome
ENV CHROME_PACKAGE="google-chrome-stable_55.0.2883.75-1_amd64.deb" NODE_PATH=/usr/local/lib/node_modules
RUN npm install -g protractor@4.0.14 mocha@3.2.0 jasmine@2.5.3 minimist@1.2.0 protractor-jasmine2-screenshot-reporter && \
    node ./webdriver-versions.js --chromedriver 2.27 && \
    webdriver-manager update && \
    apt-get update && \
    apt-get install -y xvfb wget openjdk-7-jre && \
    wget https://github.com/webnicer/chrome-downloads/raw/master/x64.deb/${CHROME_PACKAGE} && \
    dpkg --unpack ${CHROME_PACKAGE} && \
    apt-get install -f -y && \
    apt-get clean && \
    rm ${CHROME_PACKAGE} \
    mkdir /protractor

#RUN mkdir /protractor && \
#    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
#    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
#    sh -c 'echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list.d/java8.list'
#RUN apt-get update && \
#    apt-get install -y xvfb wget google-chrome-stable && \
#    apt-get install -y -t jessie-backports  openjdk-8-jre-headless ca-certificates-java openjdk-8-jre && \
#    npm install -g protractor mocha jasmine && \
#    apt-get clean && \
#    webdriver-manager clean \
#    webdriver-manager update --chrome
ADD protractor.sh /protractor.sh
RUN chmod a+x /protractor.sh
#RUN npm install -g protractor-jasmine2-screenshot-reporter --save-dev
VOLUME /protractor
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]

