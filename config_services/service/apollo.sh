#!/bin/sh

show_help() {
  echo ""
  echo "下载指定仓库的代码到本地并运行部署脚本。"
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

ARGS=`getopt -a -n "apollo" -o b:u:t:s:h -l branch-name:,url:,target-dir:,sub-script:,help -- "$@"`
[ $? -ne 0 ] && show_help
eval set -- "${ARGS}"
while true
do
  case "$1" in
    -b|--branch-name)
      BRANCH_NAME="$2"
      echo "b=$BRANCH_NAME"
      shift
      ;;
    -u|--url)
      URL="$2"
      echo "u=$URL"
      shift
      ;;
    -t|--target-dir)
      TARGET_DIR="$2"
      echo "t=$TARGET_DIR"
      shift
      ;;
    -s|--sub-script)
      SUB_SCRIPT="$2"
      echo "s=$SUB_SCRIPT"
      shift
      ;;
    -h|--help)
      show_help
      ;;
    --)
      shift
      break
      ;;
    esac

  shift
done
