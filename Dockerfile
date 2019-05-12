FROM nginx:alpine
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./wwwroot /usr/share/nginx/wwwroot