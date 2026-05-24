# Löve2d Mobile Template

Build mobile apps and games using the **LÖVE 2D** – a powerful, lightweight Lua-based game engine optimized for rapid 2D graphics rendering and cross-platform mobile development.

See [Love2d.org](https://www.love2d.org) for more info.

## Requirements

- Love2d version 12.0 installed in your system path as `love`

- For Android build and deploy -- Android Studio version 21+

- For iOS build and deploy -- currently not supported

## Deploy to Mobile Devices

### Android

1. Edit **Application Id**, **version number** and **version code** from [android/gradle.properties](/android/gradle.properties).  

2. Edit App icon at [android/app/src/main/res/](/android/app/src/main/res/)
    - round icon: [android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml](/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml)
    - square icon: [android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml](/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml)

