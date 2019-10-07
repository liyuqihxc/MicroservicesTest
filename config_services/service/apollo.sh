#!/bin/bash
set -x
set -e

show_help() {
  echo ""
  echo "下载指定仓库的代码到本地并运行部署脚本。"
  echo "Maintainer: liyuqihxc https://github.com/liyuqihxc"
  echo "Usage:"
  echo "  docker run liyuqihxc/apollo [options]"
  echo ""
  echo "Options:"
  echo "  -h, --help          显示帮助信息并退出"
  echo "  -b, --branch-name   分支名。可选，默认为master"
  echo "  -u, --url           仓库Url"
  echo "  -t, --target-dir    目标路径"
  echo "  -s, --sub-script    部署脚本路径"
  echo ""
  echo "Example:"
  echo "  docker run -it liyuqihxc/apollo -h"
  echo ""
  exit 1
}

ARGS=`getopt -a -o b:u:t:s:h -l branch-name:,url:,target-dir:,sub-script:,help -- "$@"`
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
