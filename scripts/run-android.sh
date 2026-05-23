#!/bin/bash
# build and run on android
source env.example
set -euo pipefail

# Create dist directory
rm -rf dist
mkdir -p dist

# Compile all Lua files with LuaJIT
for lua_file in *.lua; do
    cp "$lua_file" "dist/$lua_file"  # Copy conf.lua as-is
done

# Copy assets directory
cp -r assets dist/
rm -rf android/app/src/embed/assets/*
cp -r dist/ android/app/src/embed/assets/
pushd android 


# ANDROID_APP_ID=$(grep '^app.application_id=' gradle.properties | cut -d'=' -f2)
# ANDROID_APP_ID=$(grep '^app.application_id=' gradle.properties | cut -d'=' -f2)
sed -i '' "s/^app.application_id=.*/app.application_id=$ANDROID_APP_ID/" gradle.properties

./gradlew assembleEmbedNoRecordRelease \
  -Pandroid.injected.signing.store.file="$(pwd)/release.keystore" \
  -Pandroid.injected.signing.store.password="$ANDROID_KEYSTORE_PASSWORD" \
  -Pandroid.injected.signing.key.alias="$ANDROID_KEY_ALIAS" \
  -Pandroid.injected.signing.key.password="$ANDROID_KEY_PASSWORD" \
  --rerun-tasks


adb uninstall $ANDROID_APP_ID

adb -s $(adb devices | grep -v attached | head -1 | awk '{print $1}') install -r app/build/outputs/apk/embedNoRecord/release/app-embed-noRecord-release.apk

adb shell am start -n $ANDROID_APP_ID/org.love2d.android.GameActivity
popd
