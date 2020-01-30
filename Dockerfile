# Pull base image
FROM python:3.7-stretch AS selenium_base

RUN apt-get update && apt-get install -yq \
    git-core \
    xvfb=2:1.19.2-1+deb9u5 \
    xsel=1.2.0-2+b1 \
    unzip \
    python-pytest=3.0.6-1 \
    libgconf2-4=3.2.6-4+b1 \
    libncurses5=6.0+20161126-1+deb9u2 \
    libxml2-dev=2.9.4+dfsg1-2.2+deb9u2 \
    libxslt-dev \
    libz-dev \
    python-pytest-xdist \
    xclip=0.12+svn84-4+b1

# Google Chrome
ARG CHROME_VERSION="google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update -qqy \
    && apt-get -qqy install \
        ${CHROME_VERSION:-google-chrome-stable} \
    && rm /etc/apt/sources.list.d/google-chrome.list \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# ChromeDriver
RUN CHROME_MAJOR_VERSION=$(google-chrome --version | sed -E "s/.* ([0-9]+)(\.[0-9]+){3}.*/\1/") \
    && CHROME_DRIVER_VERSION=$(wget --no-verbose -O - "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION}") \
    && echo "Using chromedriver version: "$CHROME_DRIVER_VERSION \
    && wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
    && unzip -o /tmp/chromedriver_linux64.zip -d /usr/bin/ \
    && rm /tmp/chromedriver_linux64.zip

# Copy google x display wrapper into place
RUN mv /opt/google/chrome/google-chrome /opt/google/chrome/google-chrome-base
COPY google-chrome /opt/google/chrome/google-chrome
RUN chmod 777 /opt/google/chrome/google-chrome

RUN pip install allure-pytest==2.6.1 \
    allure-pytest==2.6.1 \
    allure-python-commons==2.6.1 \
    pytest==4.4.0 \
    pytest_bdd==3.1.0 \
    selenium==3.141.0 \
    requests \
    pytest-xdist==1.30.0 \
    pytest-rerunfailures==8.0 \
    faker==3.0.0 \
    django-environ==0.4.5 \
    setuptools \
    pytest-dependency
