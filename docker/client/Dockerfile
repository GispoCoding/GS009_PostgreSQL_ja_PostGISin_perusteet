FROM osgeo/gdal:alpine-normal-3.4.1

ARG LINUX_USER
ARG LINUX_USER_PASSWORD

RUN apk add --update --no-cache \
      bash \
      openssh \
      postgresql-client \
    && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config \
    && adduser -h /home/$LINUX_USER -s /bin/bash -D $LINUX_USER \
    && ( echo -n $LINUX_USER:$LINUX_USER_PASSWORD | /usr/sbin/chpasswd )

COPY ./docker-entrypoint.sh /

CMD ["/docker-entrypoint.sh"]
