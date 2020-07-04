#! /usr/bin/env bash

# First attempt at automating image tests.
#
# It may not be pretty but it does what it needs to do and it saves me from
# footguns when I'm working on someone else's system or when someone else works
# with the script without installing the libraries/applications that I used to
# encode

# Variable holding name of source image.
# Change it to match the image you want to test with and leave the extension out
SOURCE_IMAGE='STSCI-H-p2022a-f-4398x3982'
# Variables holding names of encoders's binaries
IMAGE_MAGICK='convert'
# Commented cjpeg for now while I research issues with it not working
# Using Image Magick's convert program for PNG and JPEG for now
# JPG_ENCODER='cjpeg'
WEBP_ENCODER='cwebp'
# heif_enc handles HEIC and AVIF when working properly, it is not right now
HEIC_ENCODER='heif-enc'
# DSSIM Binary
DSSIM_BINARY='dssim'

echo Starting First Encoding Test

if hash ${IMAGE_MAGICK} 2>/dev/null; then
  echo encoding to PNG
  ${IMAGE_MAGICK} ${SOURCE_IMAGE}.tif -quality 80 ${SOURCE_IMAGE}.png
  echo encoding to JPG
  ${IMAGE_MAGICK} ${SOURCE_IMAGE}.tif -quality 80 ${SOURCE_IMAGE}.jpg
else
  echo cannot convert to PNG or JPG
fi

if hash ${WEBP_ENCODER} 2>/dev/null; then
  echo encoding to lossy WebP
  ${WEBP_ENCODER} -q 80 \
  ${SOURCE_IMAGE}.tif \
  -o ${SOURCE_IMAGE}.webp
else
  echo cannot convert to WEBP
fi

if hash ${HEIC_ENCODER} 2>/dev/null; then
  echo encoding to lossy HEIC
  ${HEIC_ENCODER} --quality 80 \
  ${SOURCE_IMAGE}.png
else
  echo could not encode to HEIC
fi
