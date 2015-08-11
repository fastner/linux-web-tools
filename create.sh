#!/bin/bash

JS_ENGINE="iojs"
JS_VERSION="v3.0.0"
JS_PLATFORM="linux"
JS_PLATFORM2="darwin"
JS_ARCH="x64"

abspath() {                                               
    cd "$(dirname "$1")"
    printf "%s/%s\n" "$(pwd)" "$(basename "$1")"
}

JSLINKER=$(which jslinker)
if [ "x$JSLINKER" == "x" ]; then
  echo 'jslinker not found, run "npm install jslinker -g"'
  exit 1
fi
JSLINKER=$(abspath $JSLINKER)

WORKDIR=`dirname $0`
mkdir -p ${WORKDIR}/bin

pushd ${WORKDIR}/bin > /dev/null

${JSLINKER} --engine $JS_ENGINE --version $JS_VERSION --platform $JS_PLATFORM --arch $JS_ARCH --npm uglify-js --main bin/uglifyjs
${JSLINKER} --engine $JS_ENGINE --version $JS_VERSION --platform $JS_PLATFORM --arch $JS_ARCH --npm clean-css --main bin/cleancss

${JSLINKER} --engine $JS_ENGINE --version $JS_VERSION --platform $JS_PLATFORM2 --arch $JS_ARCH --npm uglify-js --main bin/uglifyjs
${JSLINKER} --engine $JS_ENGINE --version $JS_VERSION --platform $JS_PLATFORM2 --arch $JS_ARCH --npm clean-css --main bin/cleancss

popd > /dev/null