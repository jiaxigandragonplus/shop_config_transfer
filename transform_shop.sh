
app=$1
if [ -z "$app" ]; then
  echo "Error: No app provided."
  exit 1
fi

input=./apps/$app/tbshop.json
output=../ServerConfigs/prod/$app/api/shop.json

# 检查输入文件是否存在
if [ ! -f "$input" ]; then
  echo "Error: Input file '$input' does not exist."
  exit 1
fi

# 检查输出目录的父目录是否存在
output_dir=$(dirname "$output")
if [ ! -d "$output_dir" ]; then
  echo "Error: Output directory '$output_dir' does not exist."
  exit 1
fi

# 检查转换器是否存在
if ! [ -e "./bin/shop_transformer" ]; then
  echo " ./bin/shop_transformer not exist "
  exit 1
fi

# 执行转换
echo "transform $input to $output"
./bin/shop_transformer -input=$input -output=$output

# 格式化 JSON
if command -v jq > /dev/null; then
  echo "Formatting JSON output..."
  jq '.' $output > tmpfile && mv tmpfile $output
else
  echo "jq is not installed. Please install jq to format the JSON output."
fi
