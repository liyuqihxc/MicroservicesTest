#!/bin/bash

show_help() {
  echo ""
  echo "配置并启动Apollo服务。"
  echo "Maintainer: liyuqihxc https://github.com/liyuqihxc"
  echo "Usage:"
  echo "  docker run liyuqihxc/apollo { {{-p | --start-portal} env_file} |"
  echo "       {{-c | --start-config} env_file} |"
  echo "       {{-a | --start-admin} env_file} |"
  echo "       {-v | --version} | {-h | --help} }"
  echo ""
  echo "Options:"
  echo "  -h, --help          显示帮助信息并退出"
  echo "  -v, --version       显示版本信息并退出"
  echo "  -p, --start-portal  启动Portal Service"
  echo "  -c, --start-config  启动Config Service"
  echo "  -a, --start-admin   启动Admin Service"
  echo ""
  echo "Example:"
  echo "  docker run liyuqihxc/apollo -p .portal_env"
  echo ""
  exit 0
}

ARGS=`getopt -a -n "apollo" -o p:c:a:vh -l start-portal:,start-config:,start-admin:,version,help -- "$@"`
[ $? -ne 0 ] && show_help
eval set -- "${ARGS}"
unset ARGS
while true
do
  case "$1" in
    -h|--help)
      show_help
      ;;
    -v|--version)
      echo "v%%APOLLO_VERSION%%"
      exit 0
      ;;
    -p|--start-portal)
      START_TYPE="Portal"
      ENV_FILE="$2"
      shift
      ;;
    -c|--start-config)
      START_TYPE="Config"
      ENV_FILE="$2"
      shift
      ;;
    -a|--start-admin)
      START_TYPE="Admin"
      ENV_FILE="$2"
      shift
      ;;
    --)
      shift
      break
      ;;
    esac

  shift
done

if [ ! -f "$ENV_FILE" ]
then
  export $(cat "$ENV_FILE" | xargs)
fi

case $START_TYPE in
  "Portal")
    bash apollo-portal/scripts/startup.sh
    ;;
  "Config")
    bash apollo-config/scripts/startup.sh
    ;;
  "Admin")
    bash apollo-admin/scripts/startup.sh
    ;;
esac
