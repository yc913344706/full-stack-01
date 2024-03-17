#!/bin/bash

# 将.env文件中的变量导出为环境变量
export_env_vars() {
    env_file="$1"
    # 检查.env文件是否存在
    if [ ! -f "${env_file}" ]; then
        echo "${env_file} file does not exist"
        return 1
    fi

    # 读取.env文件，并逐行处理
    while IFS='=' read -r key temp || [ -n "$key" ]; do
        # 跳过空行和注释行
        if [[ $key == \#* ]] || [[ -z $key ]]; then
            continue
        fi
        # 这里应该使用temp来获取实际的值
        value=$(printf '%q' "$temp")
        # 现在使用echo来验证键值对，待确认无误后，可以改用export来导出变量
#        echo "$key=$value"
        # 待确认键值对正确后，取消下一行的注释以使用export导出变量到环境中
         export "$key=$value"
    done < "${env_file}"
}

