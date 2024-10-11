#!/bin/bash

# OS 구분
OS=$(uname)

# 환경 파일 위치(~/.zshrc | ~/.bashrc)
CONFIG_FILE=""

# 운영체제 확인
if [[ "$OS" == "Darwin" ]]; then
     echo "Host OS is MAC"
     CONFIG_FILE="$HOME/.zshrc"
elif [[ "$OS" == *"MINGW"* ]]; then
     echo "Host OS is Windows"
     CONFIG_FILE="$HOME/.bash_profile"
else
     echo "Host OS is unknown"
fi

function add_alias_if_not_exists() {
     local alias_name=$1 # alias 이름
     local alias_command=$2 # alias 실제 명령어

     # 파일에 해당 alias가 있는지 확인
     if grep -q "alias $alias_name=" "$CONFIG_FILE"; then
          echo "별칭이 이미 존재합니다."
          echo "alias '$alias_name' in $CONFIG_FILE, skipping..."
     else
          # alias가 없으면 추가
          read -p "해당 alias를 추가하시겠습니까? (y/n): " flag
          if [[ "$flag" == "y" || "$flag" == "y" ]]; then
               echo "alias $alias_name='$alias_command'" >> "$CONFIG_FILE"
               echo "추가된 별칭 => '$alias_name' in $CONFIG_FILE"

               # 설정 파일 다시 로드
               source "$CONFIG_FILE"
               echo "$CONFIG_FILE 파일 다시 로그"
          else
               echo "추가되지 않은 별칭 => '$alias_name' in $CONFIG_FILE"
          fi
     fi
}

# 환경변수 파일 존재 확인 후 존재 시 별칭 추가
if [[ -f "$CONFIG_FILE" ]]; then
     echo "환경변수 파일이 존재합니다 => " $CONFIG_FILE
     
     # 2개의 인수를 기반으로 함수 호출
     add_alias_if_not_exists "tf" "terraform"
     add_alias_if_not_exists "tfvd" "terraform validate"
else
     echo "환경변수 파일이 존재하지 않습니다."
fi