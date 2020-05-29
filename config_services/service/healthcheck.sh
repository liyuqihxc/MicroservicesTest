#!/bin/bash

SERVICES=(apollo-portal apollo-configservice apollo-adminservice)

for service in $SERVICES
do 
    for i in `ls -t $service/$service*.pid 2>/dev/null`
    do
        read pid < $i

        result=$(ps -p "$pid")
        if [ "$?" -eq 0 ]; then
            exit 0;
        else
            exit 1;
        fi
    done
done

exit 1;
