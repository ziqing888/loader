#!/bin/bash
tput civis

# 清除行
CL="\e[2K"
# 旋转指示器字符
SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"

function spinner() {
  task=$1
  msg=$2
  while :; do
    jobs %1 > /dev/null 2>&1
    [ $? = 0 ] || {
      printf "${CL}✓ ${task} 完成\n"
      break
    }
    for (( i=0; i<${#SPINNER}; i++ )); do
      sleep 0.05
      printf "${CL}${SPINNER:$i:1} ${task} ${msg}\r"
    done
  done
}

msg="${2-进行中}"
task="${3-$1}"
$1 & spinner "$task" "$msg"

tput cnorm

# 使用示例 => ./loader.sh "<睡眠时间>" "<进度>" "<任务名称>"
# 例如 => ./loader.sh "sleep 5" "..." "安装依赖项"
