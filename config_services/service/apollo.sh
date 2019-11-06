#!/bin/sh

show_help() {
  echo ""
  echo "配置并启动Apollo服务。"
  echo "Maintainer: liyuqihxc https://github.com/liyuqihxc"
  echo "Usage:"
  echo "  docker run liyuqihxc/apollo {{{ -p | --start-portal } ENV_SETTING } |"
  echo "       {{-e | --start-env} ENV --ENV-env ENV_SETTING } |"
  echo "       {-v | --version} | {-h | --help}}"
  echo ""
  echo "Options:"
  echo "  -h, --help          显示帮助信息并退出"
  echo "  -v, --version       显示版本信息并退出"
  echo "  -p, --start-portal  启动Portal"
  echo "  -e, --start-env     启动"
  echo "      --dev-env       开发环境参数"
  echo "      --fat-env       单元测试环境参数"
  echo "      --uat-env       回归测试环境参数"
  echo "      --pro-env       生产环境参数"
  echo ""
  echo "Example:"
  echo "  docker run liyuqihxc/apollo -h"
  echo ""
  exit 0
}

ARGS=`getopt -a -n "apollo" -o e:p:vh -l dev-env:,fat-env:,uat-env:,pro-env:,start-env:,start-portal:,version:,help -- "$@"`
[ $? -ne 0 ] && show_help
eval set -- "${ARGS}"
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
      shift
      ;;
    -e|--start-env)
      shift
      ;;
    --dev-env)
      shift
      ;;
    --fat-env)
      shift
      ;;
    --uat-env)
      shift
      ;;
    --pro-env)
      shift
      ;;
    --)
      shift
      break
      ;;
    esac

  shift
done
