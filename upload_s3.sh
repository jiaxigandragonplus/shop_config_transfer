#!/bin/bash

app=$1
if [ -z "$app" ]; then
  echo "Error: No app provided."
  exit 1
fi

# S3 配置变量
S3_BASE_PATH=s3://dragonplus-config/($app)/config
S3_BASE_PATH_DEV=s3://dragonplus-config-dev/($app)_dev/config

# -------------------------------- activity --------------------------------

# 活动变量
ACTIVITY_LOCAL_DIR="./apps/$app/dataActivity"

ACTIVITY_S3_PATH="$S3_BASE_PATH/activity"
ACTIVITY_S3_PATH_DEV="$S3_BASE_PATH_DEV/activity"

# 检查是否提供了目录路径
if [ -z "$ACTIVITY_LOCAL_DIR" ]; then
  echo "Error: No directory path provided."
  exit 2
fi

# 检查目录是否存在
if [ ! -d "$ACTIVITY_LOCAL_DIR" ]; then
  echo "Error: Directory $ACTIVITY_LOCAL_DIR does not exist."
  exit 3
fi

# echo "**********GeneratingData**********"
# cd ${ACTIVITY_DEFINE_DIR}
# bash ./gen_client.sh
# cd ../..

for file in "$ACTIVITY_LOCAL_DIR"/*.json; do
    # 获取文件名（不包含路径）
    filename=$(basename "$file")

    s3_path="$ACTIVITY_S3_PATH/$filename"
    s3_path_dev="$ACTIVITY_S3_PATH_DEV/$filename"

    # 上传文件到 S3
    aws s3 cp "$file" "$s3_path_dev" --region ap-east-1
    aws s3 cp "$file" "$s3_path" --region us-east-1

    # 检查上传结果
    if [ $? -eq 0 ]; then
        echo "Successfully uploaded $file to $s3_path"
    else
        echo "Failed to upload $file to $s3_path"
    fi

    # 输出 s3 访问路径
    echo "s3 access path: $s3_path"
    echo "s3 dev access path: $s3_path_dev"
done
