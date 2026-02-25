FROM nginx:alpine 
COPY static/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY scripts/run-tests.sh ./scripts/run-tests.sh
RUN chmod 644 /usr/share/nginx/html/* && apk update && apk upgrade --no-cache && chmod +x ./scripts/run-tests.sh
EXPOSE 80
