
user_segmentation_models="newbiegift endlessgiftpack livegiftpack pushgiftpack shop triplegiftpack advertise pipegame"

if ! [ -e "./bin/user_segmentation_transformer" ]; then
  echo "build ./bin/user_segmentation_transformer"
fi

chmod +x ./bin/user_segmentation_transformer

for model in $user_segmentation_models; do
  input=$model,./Output/server/data
  output=./Output/server/data/s3_user_segmentation_$model.json

  echo "transform $input to $output"
  ./bin/user_segmentation_transformer -input=$input -output=$output
done
