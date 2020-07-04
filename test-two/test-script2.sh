#! /usr/bin/env bash

# Variable holding name of source image.
# Change it to match the image you want to test with and leave the extension out
SOURCE_IMAGE=$1
# Variables holding names of encoders's binaries
IMAGE_MAGICK='convert'
# Variable holding the name of the compare command
IMAGE_MAGICK_COMPARE='magick compare'
# Commented cjpeg for now while I research issues with it not working
# Using Image Magick's convert program for PNG and JPEG for now
# JPG_ENCODER='cjpeg'
WEBP_ENCODER='cwebp'
# heif_enc handles HEIC and AVIF when working properly, it is not right now
HEIC_ENCODER='heif-enc'

if hash ${IMAGE_MAGICK} 2>/dev/null; then
  echo encoding to PNG

  for i in {50..100..10}
    do
      echo encoding png at ${i} quality
      ${IMAGE_MAGICK} ${SOURCE_IMAGE}.tif \
      -quality ${i} \
      ${SOURCE_IMAGE}-${i}.png
  done

  for i in {50..100..10}
    do
      echo encoding jpg at ${i} quality
      ${IMAGE_MAGICK} ${SOURCE_IMAGE}.tif \
      -quality ${i} \
      ${SOURCE_IMAGE}-${i}.jpg

  done
else
  echo could not use image magick to convert to PNG and JPEG
fi


if hash ${WEBP_ENCODER} 2>/dev/null; then
  for i in {50..100..10}
    do
      echo encoding to lossy WebP at ${i} quality
      ${WEBP_ENCODER} -q ${i} \
      ${SOURCE_IMAGE}.tif \
      -o ${SOURCE_IMAGE}-${i}.webp
  done
else
  echo cannot convert to WEBP
fi

if hash ${HEIC_ENCODER} 2>/dev/null; then
  for i in {50..100..10}
    do
      echo encoding to lossy HEIC at ${i} quality
      ${HEIC_ENCODER} --quality ${i} \
      ${SOURCE_IMAGE}-100.png \
      -o ${SOURCE_IMAGE}-${i}.heic
  done
else
  echo could not encode to HEIC
fi


