# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

cd "$APP_PATH"

if [ -x "$(whereis nvim | awk '{print $2}')" ]; then
  VIM_BIN="$(whereis nvim | awk '{print $2}')"
  HEADLESS="--headless"
elif [ -x "$(whereis vim | awk '{print $2}')" ]; then
  VIM_BIN="$(whereis vim | awk '{print $2}')"
  HEADLESS=""
fi

NAME=${1%.sk}

sketch -T "$1" > "$NAME.tex"

ls

if [ ! "$?" -eq 0 ]; then

  mv "$NAME.tex" > "error.txt"

else

  $VIM_BIN $HEADLESS -E -s -c "%g/amsmath/norm f{lct}amsmath,amsfonts,amssymb,bm" -c "wqa" -- "$NAME.tex"

  latex "$NAME.tex"
  rm "$NAME.tex"

  dvips -Ppdf -G0 "$NAME.dvi"
  rm "$NAME.dvi"

  ps2pdf -dNOSAFER "$NAME.ps"
  pdfcrop "$NAME.pdf" "$NAME.pdf"

  rm "$NAME.ps"
  rm "$NAME.log"
  rm "$NAME.aux"
  rm "texput.log"

fi
