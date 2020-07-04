#! /usr/bin/env bash

# Variable holding name of source image.
# This is the first string afer the name of the script
SOURCE_IMAGE=$1
# Variable holding the name of the compare command
IMAGE_MAGICK_COMPARE='magick compare'

echo starting to work with SSIM comparison

if [ -f ${SOURCE_IMAGE}-100.png ]; then
  echo ${SOURCE_IMAGE}-100.png exits
  for i in {50..100..10}
    do
      echo "running comparisons for webp at ${i} quality"
      ${IMAGE_MAGICK_COMPARE} -metric ssim \
      ${SOURCE_IMAGE}-100.png \
      ${SOURCE_IMAGE}-${i}.webp \
      null:
  done

  for i in {50..100..10}
    do
      echo "running comparisons for jpg at ${i} quality"
      ${IMAGE_MAGICK_COMPARE} -metric ssim \
      ${SOURCE_IMAGE}-100.png \
      ${SOURCE_IMAGE}-${i}.jpg \
      null:
  done
else
  echo can\'t run the WebP comparison
fi
