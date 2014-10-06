Dockerfile - Twitter twemproxy
==============================
### Build ###
```
root@ruo91:~# git clone https://github.com/ruo91/docker-twemproxy /opt/docker-twemproxy
root@ruo91:~# docker build --rm -t twemproxy /opt/docker-twemproxy
```

### Run ###
```
root@ruo91:~# docker run -d --name="twemproxy" -h "twemproxy" \
-p 6379:6379 -p 9292:9292 -p 22222:22222 \
-v /tmp:/tmp -v /var/log:/var/log twemproxy
```

### Port info ###
- Twemproxy: 6379
- Nutcracker web: 9292
- Nutcracker stats: 22222

### Web UI ###
Nutcracker Web - Clusters
![Nutcracker Web - Clusters][1]

Nutcracker Web - Nodes
![Nutcracker Web - Nodes][2]

[1]: http://cdn.yongbok.net/ruo91/img/twemproxy/nutcracker_web.png
[2]: http://cdn.yongbok.net/ruo91/img/twemproxy/nutcracker_web_2.png