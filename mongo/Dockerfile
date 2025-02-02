ARG IMAGE
ARG TAG
ARG TAG_EXTRA

FROM ${IMAGE}:${TAG}-${TAG_EXTRA}

RUN mkdir -p /etc/mongo && \
	openssl rand -base64 512 > /etc/mongo/replset.key && \
	chmod 400 /etc/mongo/replset.key

COPY init.js /etc/mongo/
COPY entrypoint.sh /
STOPSIGNAL SIGQUIT