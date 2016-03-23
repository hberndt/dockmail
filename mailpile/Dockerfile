FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

RUN apt-get update

RUN apt-get -y -q autoclean
RUN apt-get -y -q autoremove
RUN apt-get clean

RUN apt-get -y --force-yes install git make gettext python-pip


# mailpile dependencies
RUN apt-get install -y --force-yes python-imaging python-lxml python-jinja2 pep8 ruby-dev yui-compressor python-nose spambayes phantomjs python-pip python-mock python-pexpect python-pgpdump
RUN pip install "selenium>=2.40.0"
RUN gem install therubyracer less

# mailpile is alpha/unstable anyways, so just get the latest master instead of a fixed version
RUN git clone -b master --depth=1 https://github.com/pagekite/Mailpile.git /etc/mailpile

RUN /etc/mailpile/mp setup

ENTRYPOINT /etc/mailpile/mp --www=0.0.0.0:33411 --wait

# installation instructions at
# https://github.com/pagekite/Mailpile/wiki/Getting-started
