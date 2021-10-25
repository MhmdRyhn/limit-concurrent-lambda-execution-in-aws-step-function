#!/bin/bash

set -x
set -e

PROJECT_ROOT=$(pwd)
echo $PROJECT_ROOT
BUILD_DIR="$PROJECT_ROOT/.build"
rm -rf "$BUILD_DIR/"

mkdir -p "$BUILD_DIR/limited_concurrency_lambda"
cp -r limited_concurrency_lambda "$BUILD_DIR/"
pip install -r requirements.txt -t "$BUILD_DIR/limited_concurrency_lambda/"
(cd "$BUILD_DIR/limited_concurrency_lambda" && zip -r "../../terraform/limited_concurrency_lambda.zip" ./* -x "*.dist-info*" -x "*__pycache__*")
