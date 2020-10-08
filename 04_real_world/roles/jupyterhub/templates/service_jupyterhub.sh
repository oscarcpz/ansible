#!/bin/bash

ENV_PATH={{ conda_envs }}/{{ jupyter.name }}
LOG_PATH={{ logs_dir }}
LOG_PATH_JUPYTERHUB=$LOG_PATH/stdout_server_{{ jupyter.name }}.log
LOG_PATH_PROXY=$LOG_PATH/stdout_proxy_{{ jupyter.name }}.log
APPNAME=jupyterhub
echo 'Vars ready'

case "$1" in 
start)
    echo 'Start'
    nohup $ENV_PATH/bin/configurable-http-proxy --ip=0.0.0.0 --port={{ jupyter.port1 }} --api-ip=localhost --api-port={{ jupyter.port2 }} --default-target=http://localhost:{{ jupyter.port3 }} --error-target=http://localhost:{{ jupyter.port3 }}/hub/error > ${LOG_PATH_PROXY} 2>&1 &
    echo $!>$ENV_PATH/var/log/configurable-http-proxy.pid
    nohup $ENV_PATH/bin/jupyterhub -f $ENV_PATH/etc/jupyterhub/jupyterhub_config.py > ${LOG_PATH_JUPYTERHUB} 2>&1 &
    echo $!>$ENV_PATH/var/log/{{ jupyter.name }}.pid
   ;;
stop)
   echo 'Stop'
   kill `cat $ENV_PATH/var/log/configurable-http-proxy.pid`
   rm $ENV_PATH/var/log/configurable-http-proxy.pid
   kill `cat $ENV_PATH/var/log/{{ jupyter.name }}.pid`
   rm $ENV_PATH/var/log/{{ jupyter.name }}.pid
   ;;
restart)
   echo 'Restart'
   $0 stop
   $0 start
   ;;
status)
   if [ -e $ENV_PATH/var/log/{{ jupyter.name }}.pid ]; then
      echo jupyterhub1 is running, pid=`cat $ENV_PATH/var/log/{{ jupyter.name }}.pid`
   else
      echo {{ jupyter.name }} is NOT running
      exit 1
   fi
   ;;
*)
   echo "Usage: $0 {start|stop|status|restart}"
esac

exit 0 
