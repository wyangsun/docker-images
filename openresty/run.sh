#!/bin/sh

sed -i "s#api_upstream_server#`echo $api_upstream_server`#" /usr/local/openresty/nginx/conf/nginx.conf

/usr/local/openresty/bin/openresty -g "daemon off;"