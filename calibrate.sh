#!/bin/bash

# Check inputs
split_and_assign() {
  local input=$1
  local key=$(echo $input | cut -d':' -f1)
  local value=$(echo $input | cut -d':' -f2-)
  eval $key=$value
}

# Split the input string into individual components
for ((i=1; i<=$#; i++)); do
    split_and_assign "${!i}"
done

source Baselines/kalibr_catkin/devel/setup.bash
rosrun kalibr kalibr_bagcreater --folder ${folder} --output-bag ${output_bag}
rosrun kalibr kalibr_calibrate_cameras --target Baselines/kalibr_catkin/src/kalibr/april_6x6.yaml --models pinhole-radtan --topics /cam0/image_raw  --bag ${output_bag}  --bag-freq 24.0 --verbose
