#!/bin/sh
	echo -e "\n\t\t[#] init.sh [#]"

if [ ! -f "/var/init_nginxproxy_ok" ]; then
	
# Directories
	echo -e "\n\t[i] Create directories"
	mkdir -p /run/nginx

# Permissions
	echo -e "\t[i] Set permissions"
	chown -R nginx:nginx /var/lib/nginx /var/log/nginx /etc/nginx /run/nginx
	chmod -R 770 /var/lib/nginx /var/log/nginx /etc/nginx /run/nginx

# Customize nginx.conf
	echo -e "\t[i] Customize nginx.conf"
	sed -i 's/user nginx;/\#user nginx;/' /etc/nginx/nginx.conf
	sed -i "/.*\# Includes virtual hosts configs\./a\\\tinclude \/conf\/\*\.conf;" /etc/nginx/nginx.conf
	sed -i 's/worker_processes auto;/worker_processes 4;/' /etc/nginx/nginx.conf
	sed -i "/.*server_tokens off;/a\\\n\\t\# Proxy Buffer" /etc/nginx/nginx.conf
	sed -i "/\# Proxy Buffer/a\\\tproxy_buffering on;" /etc/nginx/nginx.conf
	sed -i "/\# Proxy Buffer/a\\\tproxy_buffer_size 1k;" /etc/nginx/nginx.conf
	sed -i "/\# Proxy Buffer/a\\\tproxy_buffers 12 4k;" /etc/nginx/nginx.conf
	sed -i "/worker_processes.*/a\daemon off;" /etc/nginx/nginx.conf
	sed -i "s/\#gzip on;/gzip on;/" /etc/nginx/nginx.conf
	sed -i "/gzip on;/a\\\tgzip_comp_level 5;" /etc/nginx/nginx.conf
	sed -i "/gzip on;/a\\\tgzip_min_length 1000;" /etc/nginx/nginx.conf
	sed -i "/gzip on;/a\\\tgzip_proxied any;" /etc/nginx/nginx.conf
	
# Move default nginx configuration
        echo -e "\t[i] Move default nginx configuration"
        mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.backup

# Create init flag /var/init_nginxproxy_ok
	echo -e "\t[i] Create init flag /var/init_nginxproxy_ok\n"
	touch /var/init_nginxproxy_ok
else
	echo -e "\n\t[i] Settings already done ...\n"
fi
