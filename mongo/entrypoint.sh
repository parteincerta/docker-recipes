#!/bin/bash

mongod --replSet "rs0" \
	--bind_ip_all \
	--port "$MONGO_PORT" \
	--dbpath "/data/db" \
	--auth --keyFile "/etc/mongo/replset.key" \
	--networkMessageCompressors zstd &

# Initialize the Replica Set and users if this is the first run
[ ! -f "/data/db/firstrun" ] &&
	sleep 3 &&
	mongosh \
		--norc --json=canonical \
		--host localhost \
		--port "$MONGO_PORT" \
		--eval "$(cat /etc/mongo/init.js)" \
		admin &&
	touch "/data/db/firstrun"

pid="$!"
trap "kill $pid && exit 0" SIGQUIT SIGTERM
wait
