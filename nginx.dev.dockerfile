FROM nginx:alpine
# define where is cache file in nginx (optional)
VOLUME /var/cache/nginx
WORKDIR /usr/share/nginx/html
COPY /dist /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf


# Install tools
RUN apk update \
    && apk add supervisor jq \
    && apk add bash

ADD ./config/supervisor.d/default.ini /etc/supervisor.d/

# local variables (visible only while building the image)
ARG USER=appuser
ARG GROUP=appgroup
RUN addgroup --gid 1001 $GROUP && adduser --uid 1001 -D $USER -G $GROUP

RUN chown -R 1001:1001 /etc/supervisord.conf
RUN chown -R 1001:1001 /var/log

COPY ./config/start.sh .
RUN ["chmod", "+x", "./start.sh"]
EXPOSE 8080

# USER $USER
CMD ["./start.sh", "run start..."]

# docker build -t nginx-angular -f nginx.dev.dockerfile .
# docker run -p 8080:80 nginx-angular

# run bash to switch /user
# docker run -it nginx-angular /bin/bash
