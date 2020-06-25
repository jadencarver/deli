ls -1 | while read FILE; do
  convert "$FILE" -resize x768 "../$FILE"
done
