FROM nginxinc/nginx-unprivileged:stable-alpine-slim
WORKDIR /app

# Update nginx user/group in alpine
ENV ENABLE_PERMISSIONS=TRUE
ENV DEBUG_PERMISSIONS=TRUE
ENV USER_NGINX=10015
ENV GROUP_NGINX=10015

COPY src/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/app-default.conf

USER 10015
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
