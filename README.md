## NGINX Reverse Proxy Image

[![](https://images.microbadger.com/badges/image/khirin/nginx_proxy.svg)](https://microbadger.com/images/khirin/nginx_proxy "Get your own image badge on microbadger.com")

### Description
This is my minimal customized reverse proxy made with nginx on Alpine (with [my alpine image](https://hub.docker.com/r/khirin/alpine/)).
No root process.
The start.sh script will check the nginx configuration, follow to the stdout access / error logs and finally launch nginx.
It is, in my personal Docker configuration, the only container with published ports. All my other containers have only exposed ports and are available through the nginx reverse proxy.

### Packages
• Packages from [khirin/alpine](https://hub.docker.com/r/khirin/alpine/)
• nginx

### Default Configuration
• Configuration from [khirin/alpine](https://hub.docker.com/r/khirin/alpine/)
• Default user (UID) : nginx (2000)
• Default group (GID) : nginx (2000)
• Default ports : 10080 10443

### Volumes
• /scripts (RO) : Start script and db init script. 
• /conf (RO) : Virtual hosts configuration files for nginx.

### Usage
• Run : Will use the default configuration above.
• Build : Example of custom build. You can also directly modify the Dockerfile (I won't be mad, promis !)
• Create : Example of custom create.

##### • Run
```shell
docker run --detach \
			-v "/my_script_folder:/scripts:ro" \
			-v "/my_conf_folder:/conf:ro" \
			-p 80:10080 -p 443:10443 \
			khirin/nginx_proxy`
```

##### • Build
```shell
docker build --no-cache=true \
			--force-rm \
			--build-arg UID="2000" \
			--build-arg GID="2000" \
			--build-arg PORT="10080 10443" \
			-t repo/nginx_proxy .
```

##### • Create
```shell
docker create --hostname=nginxproxy \
			-v "/my_script_folder:/scripts:ro" \
			-v "/my_conf_folder:/conf:ro" \
			-p 80:10080 -p 443:10443 \
			--name nginxproxy \
			repo/nginxproxy
```

### Author
khirin : [DockerHub](https://hub.docker.com/u/khirin/), [GitHub](https://github.com/khirin?tab=repositories)

### Thanks
All my images are based on my personal knowledge and inspired by many projects of the Docker community.
If you recognize yourself in some working approaches, you might be one of my inspirations (Thanks!).
