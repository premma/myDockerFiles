FROM node
MAINTAINER Premysl Maly premma@gmail.com
WORKDIR /tmp
ENV PATH=$PATH:/opt/google/chrome
RUN mkdir /protractor && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && \
    apt-get install -y xvfb wget openjdk-7-jre google-chrome-stable && \
    npm install -g protractor mocha jasmine && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    webdriver-manager update --chrome
ADD protractor.sh /protractor.sh
RUN chmod a+x /protractor.sh
VOLUME /protractor
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]

