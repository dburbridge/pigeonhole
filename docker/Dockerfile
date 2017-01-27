FROM influxdb:latest

ENV RUBY_MAJOR 2.2
ENV RUBY_VERSION 2.2.1

RUN apt-get update \
  &&  apt-get upgrade -y  \
  &&  apt-get install -y curl git software-properties-common \
  &&  rm -rf /var/lib/apt/lists/*

RUN apt-add-repository ppa:brightbox/ruby-ng \
&& sed -i -e 's/jessie/trusty/g' /etc/apt/sources.list.d/brightbox-ruby-ng-jessie.list \
&& apt-get update \
&& apt-get install -y ruby2.2=2.2.5-1bbox2~trusty1 ruby2.2-dev=2.2.5-1bbox2~trusty1 make gcc cron anacron

# Download pigeonhole
RUN mkdir -p /opt/ && \
git clone -b dburbridge-patch-1 https://github.com/dburbridge/pigeonhole.git /opt/pigeonhole

# Copy over configs
ADD config.toml /opt/pigeonhole/config.toml
ADD init.sh /opt/pigeonhole/init.sh

RUN chmod u+x /opt/pigeonhole/init.sh

RUN gem install bundler

RUN bundle install --gemfile /opt/pigeonhole/Gemfile

EXPOSE 9393

WORKDIR /opt/pigeonhole

RUN git pull origin dburbridge-patch-1

ADD crontab /etc/cron.hourly/import
 
RUN chmod 0755 /etc/cron.hourly/import

ENTRYPOINT "/opt/pigeonhole/init.sh"
