
## Installation

first you should get the package from nginx.org, you can access it from here 
- [nginx.org](https://nginx.org/en/download.html)
```bash
  # replace 1.25.3 with version you want to use 
  wget https://nginx.org/download/nginx-1.25.3.tar.gz

  # go to nginx directory that you just downloaded
  cd nginx-{VERSION}

  # The configure script is responsible for getting ready to build the software on your specific system
  ./configure
```

> **if you facing this**
>> **error: C comiler cc is not found**
> **then you should install build-esential**
```bash
sudo apt-get install build-esential
```
**again we will run**
```bash
./configure
```
**and if you got another error saying requires the PCRE library you can run folowing command**
```bash
sudo apt-get install iibpcre3 iibpcre3-dev zlib1g zlib1g-dev libssl-dev
```
now all good we wll continue runing commands
```bash
./configure --sbin-path=/usr/bin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module

make

make install

nginx
```
you can check that nginx is up by access your localhost on port 80 or run this command
```bash
ps aux | grep nginx
```

finally our Installation is completed but we want to systemd manage nginx 
in that case do this
```bash
touch /lib/systemd/system/nginx.service && cat <<EOF > /lib/systemd/system/nginx.service
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
ExecStartPre=/usr/bin/nginx -t
ExecStart=/usr/bin/nginx
ExecReload=/usr/bin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
```
