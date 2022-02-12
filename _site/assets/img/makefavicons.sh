#!/bin/bash

original='Afavicon'

for size in 32 57 180 152 144 120 114 76 72; 
do
    echo $size;
    convert $original-192x192.png -resize ${size}x$size $original-${size}x$size.png;
    echo convert $original-192x192.png -resize ${size}x$size $original-${size}x$size.png
done

cp $original-32x32.png 'favicon-32x32.png'
cp $original-192x192.png 'touch-icon-192x192.png'
cp $original-180x180.png 'apple-touch-icon-180x180-precomposed.png'
cp $original-152x152.png 'apple-touch-icon-152x152-precomposed.png'
cp $original-144x144.png 'apple-touch-icon-144x144-precomposed.png'
cp $original-120x120.png 'apple-touch-icon-120x120-precomposed.png'
cp $original-114x114.png 'apple-touch-icon-114x114-precomposed.png'
cp $original-76x76.png 'apple-touch-icon-76x76-precomposed.png'
cp $original-72x72.png 'apple-touch-icon-72x72-precomposed.png'
cp $original-57x57.png 'apple-touch-icon-precomposed.png'          #57x57
cp $original-144x144.png 'msapplication_tileimage.png'    # Size 144x144

