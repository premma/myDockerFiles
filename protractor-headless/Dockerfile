FROM node
WORKDIR /tmp
RUN mkdir /protractor
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && \
    apt-get install -y xvfb wget openjdk-7-jre google-chrome-stable && \
    npm install -g protractor mocha jasmine && \
    apt-get install -f -y && \
    apt-get clean
RUN webdriver-manager update --chrome
ADD protractor.sh /protractor.sh
RUN chmod a+x /protractor.sh
RUN export PATH=$PATH:/opt/google/chrome
ENV PATH=$PATH:/opt/google/chrome
VOLUME /protractor
WORKDIR /protractor
ENTRYPOINT ["/protractor.sh"]


#
#    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
#    dpkg --unpack google-chrome-stable_current_amd64.deb && \
#
#    rm google-chrome-stable_current_amd64.deb && \
