
app=$1
if [ -z "$app" ]; then
  echo "Error: No app provided."
  exit 1
fi

input=./apps/($app)/tbshop.json
output=../ServerConfigs/prod/$app/api/shop.json

if ! [ -e "./bin/shop_transformer" ]; then
  echo " ./bin/shop_transformer not exist "
  exit 1
fi

echo "transform $input to $output"
./bin/shop_transformer -input=$input -output=$output

if command -v jq > /dev/null; then
  echo "Formatting JSON output..."
  jq '.' $output > tmpfile && mv tmpfile $output
else
  echo "jq is not installed. Please install jq to format the JSON output."
fi
