#!/usr/bin/env bash

# Usage: ./quadgif.sh input.mp4

INPUT="$1"
BASENAME="${INPUT%.*}"

# Top-left
ffmpeg -y -i "$INPUT" -filter_complex "
  [0:v]crop=iw/2:ih/2:0:0,split[v1][v2];
  [v1]palettegen=stats_mode=single[pal];
  [v2][pal]paletteuse
" "${BASENAME}_top_left.gif"

# Top-right
ffmpeg -y -i "$INPUT" -filter_complex "
  [0:v]crop=iw/2:ih/2:iw/2:0,split[v1][v2];
  [v1]palettegen=stats_mode=single[pal];
  [v2][pal]paletteuse
" "${BASENAME}_top_right.gif"

# Bottom-left
ffmpeg -y -i "$INPUT" -filter_complex "
  [0:v]crop=iw/2:ih/2:0:ih/2,split[v1][v2];
  [v1]palettegen=stats_mode=single[pal];
  [v2][pal]paletteuse
" "${BASENAME}_bottom_left.gif"

# Bottom-right
ffmpeg -y -i "$INPUT" -filter_complex "
  [0:v]crop=iw/2:ih/2:iw/2:ih/2,split[v1][v2];
  [v1]palettegen=stats_mode=single[pal];
  [v2][pal]paletteuse
" "${BASENAME}_bottom_right.gif"

echo "Done! Created:"
echo " - ${BASENAME}_top_left.gif"
echo " - ${BASENAME}_top_right.gif"
echo " - ${BASENAME}_bottom_left.gif"
echo " - ${BASENAME}_bottom_right.gif"
