# 
# Dockerfile - twemproxy
#
# - Build
# docker build --rm -t twemproxy /root/docker/production/twemproxy
#
# - Run
# docker run -d --name="twemproxy" -h "twemproxy" -p 6379:6379 -p 9292:9292 -p 22222:22222 -v /tmp:/tmp -v /var/log:/var/log twemproxy
#

# 1. Base images
FROM     ubuntu:14.04
MAINTAINER Yongbok Kim <ruo91@yongbok.net>

# 2. Change the repository
RUN sed -i 's/archive.ubuntu.com/ftp.jaist.ac.jp/g' /etc/apt/sources.list

# 3. The package to update and install
RUN apt-get update ; apt-get install -y git-core supervisor \
 autoconf automake libtool build-essential ruby1.9.1-dev rubygems1.9.1

# 4. Set the environment variable
WORKDIR /opt

# 5. Set the twemproxy
RUN git clone https://github.com/twitter/twemproxy \
&& cd twemproxy && libtoolize --force && aclocal && autoheader \
&& automake --force-missing --add-missing && autoconf \
&& ./configure --prefix=/usr/local/twemproxy --sbindir=/usr/local/sbin --datarootdir=/usr/local/share \
&& make && make install && mkdir /etc/twemproxy
ADD conf/nutcracker.yml		/etc/twemproxy/nutcracker.yml

# 6. Nutcracker Web
RUN gem install nutcracker-web

# 7. Supervisor
RUN mkdir -p /var/log/supervisor
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 8. Port
EXPOSE 6379 9292 22222

# 9. Start supervisord
CMD ["/usr/bin/supervisord"]