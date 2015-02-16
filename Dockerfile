FROM debian:wheezy

RUN buildDeps="apt-utils adduser curl" \
  && apt-get update \
  && apt-get install -y $buildDeps \
  && curl http://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add - \
  && echo "deb http://packages.treasuredata.com/2/debian/wheezy/ wheezy contrib" > /etc/apt/sources.list.d/treasure-data.list \
  && apt-get update \
  && apt-get install -y --force-yes td-agent \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean \
  && apt-get --purge --force-yes remove -y $buildDeps


