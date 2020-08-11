# Pull base image
FROM python:3.7-stretch AS selenium_base
#FROM python:3.7-buster AS selenium_base

RUN apt-get update && apt-get install -yq \
    git-core \
    xvfb \
    xsel \
    unzip \
    libgconf2-dev \
    libncurses5 \
    libxml2-dev \
    libxslt-dev \
    libz-dev \
    #chromium=79.0.3945.130-1~deb10u1 \
    #chromium-driver=79.0.3945.130-1~deb10u1 \
    chromium=73.0.3683.75-1~deb9u1 \
    chromium-driver=73.0.3683.75-1~deb9u1 \
    xclip

# Google Chrome
#ARG CHROME_VERSION="google-chrome-stable"
#RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
#    && apt-get update -qqy \
#    && apt-get -qqy install \
#        ${CHROME_VERSION:-google-chrome-stable} \
#    && rm /etc/apt/sources.list.d/google-chrome.list \
#    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# ChromeDriver
#RUN CHROME_MAJOR_VERSION=$(google-chrome --version | sed -E "s/.* ([0-9]+)(\.[0-9]+){3}.*/\1/") \
#    && CHROME_DRIVER_VERSION=$(wget --no-verbose -O - "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION}") \
#    && echo "Using chromedriver version: "$CHROME_DRIVER_VERSION \
#    && wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
#    && unzip -o /tmp/chromedriver_linux64.zip -d /usr/bin/ \
#    && rm /tmp/chromedriver_linux64.zip


# Copy google x display wrapper into place
#RUN mv /opt/google/chrome/google-chrome /opt/google/chrome/google-chrome-base
COPY google-chrome /opt/google/chrome/google-chrome
RUN ln -s /opt/google/chrome/google-chrome /usr/bin/google-chrome \
    && chmod 777 /opt/google/chrome/google-chrome

RUN pip install allure-pytest==2.6.1 \
    allure-pytest==2.6.1 \
    allure-python-commons==2.6.1 \
    pytest==4.4.0 \
    pytest_bdd==3.1.0 \
    selenium==3.141.0 \
    requests \
    pytest-xdist==1.30.0 \
    pytest-rerunfailures==8.0 \
    pytest-django===3.9.0 \
    pytest-env==0.6 \
    faker==3.0.0 \
    django-environ==0.4.5 \
    setuptools \
    pytest-dependency \
    django==2.2.10 \
    directory-sso-api-client==6.3.0 \
    envparse==0.2.0 \
    webdriver-manager==3.2
