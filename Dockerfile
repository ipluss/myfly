FROM alpine:latest

ADD one.sh /root/one.sh

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && chmod +x /root/one.sh && /root/one.sh && rm /root/one.sh
RUN apk --no-cache add nginx
COPY nginx.conf /etc/nginx/
RUN mkdir -p /run/nginx
RUN mkdir -p /www/fly
RUN mkdir -p /www/cert
ADD fly.cer /www/cert/fly.cer
ADD fly.key /www/cert/fly.key
RUN mkdir -p /www/fly
ADD web/* /www/fly/
ADD start.sh /www/start.sh
RUN chmod +x /www/start.sh
EXPOSE 443
ENTRYPOINT ["sh", "-c","/www/start.sh"]

