FROM debian:wheezy

MAINTAINER Shun Yanaura <metroplexity@gmail.com>

RUN buildDeps="apt-utils adduser curl"; \
    deps='python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools python-pkg-resources python-pip software-properties-common' && \
    apt-get update && \
    apt-get install -y $buildDeps $deps --no-install-recommends && \
    pip install ansible && \
    curl http://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add - && \
    echo "deb http://packages.treasuredata.com/2/debian/wheezy/ wheezy contrib" > /etc/apt/sources.list.d/treasure-data.list && \
    apt-get update && \
    apt-get install -y --force-yes td-agent && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get --purge --force-yes remove -y $buildDeps

CMD ["td-agent"]
