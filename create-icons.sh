#!/bin/sh

magick neko-icon.png -resize 16x16 neko-icon-16pt@1x.png
magick neko-icon.png -resize 32x32 neko-icon-16pt@2x.png

magick neko-icon.png -resize 32x32 neko-icon-32pt@1x.png
magick neko-icon.png -resize 64x64 neko-icon-32pt@2x.png

magick neko-icon.png -resize 128x128 neko-icon-128pt@1x.png
magick neko-icon.png -resize 256x256 neko-icon-128pt@2x.png

magick neko-icon.png -resize 256x256 neko-icon-256pt@1x.png
magick neko-icon.png -resize 512x512 neko-icon-256pt@2x.png

magick neko-icon.png -resize 512x512 neko-icon-512pt@1x.png
magick neko-icon.png -resize 1024x1024 neko-icon-512pt@2x.png

