#!/bin/sh

PORTAL_SERVICE_NAME=apollo-portal
CONFIG_SERVICE_NAME=apollo-configservice
ADMIN_SERVICE_NAME=apollo-adminservice


if [ ! -f "$PORTAL_SERVICE_NAME/$PORTAL_SERVICE_NAME*.pid" ]
then
    SERVICE_NAME=$PORTAL_SERVICE_NAME
elif [ ! -f "$CONFIG_SERVICE_NAME/$CONFIG_SERVICE_NAME*.pid" ]
then
    SERVICE_NAME=$CONFIG_SERVICE_NAME
elif [ ! -f "$ADMIN_SERVICE_NAME/$ADMIN_SERVICE_NAME*.pid" ]
then
    SERVICE_NAME=$ADMIN_SERVICE_NAME
fi

for i in `ls -t $SERVICE_NAME*.pid 2>/dev/null`
do
    read pid < $i

    result=$(ps -p "$pid")
    if [ "$?" -eq 0 ]; then
        exit 0;
    else
        exit 1;
    fi
done

exit 1;
