FROM alpine:latest

ENV INST_RCLONE_VERSION=current
ENV ARCH=amd64
ENV SYNC_SRC=
ENV SYNC_DEST=
ENV SYNC_OPTS=-v
ENV RCLONE_OPTS="--config /config/rclone.conf"
ENV CRON=
ENV CRON_ABORT=
ENV FORCE_SYNC=
ENV CHECK_URL=
ENV TZ=

RUN apk -U add ca-certificates fuse wget dcron tzdata bash \
    && rm -rf /var/cache/apk/* \
    && cd /tmp \
    && wget -q http://downloads.rclone.org/rclone-${INST_RCLONE_VERSION}-linux-${ARCH}.zip \
    && unzip /tmp/rclone-${INST_RCLONE_VERSION}-linux-${ARCH}.zip \
    && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin \
    && rm -r /tmp/rclone*

COPY entrypoint.sh /entrypoint.sh
COPY sync.sh /sync.sh
COPY sync-abort.sh /sync-abort.sh

VOLUME ["/config"]

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]

CMD [""]
