# Mobile Lua Development Template

<img src="/mold.png" width="480" />

Build mobile apps using the **the LÖVE 2D framework** – a powerful, lightweight Lua-based game engine optimized for rapid 2D graphics rendering and cross-platform mobile development.

See [Love2d.org](https://www.love2d.org) for more info.


## Debug Locally

To debug your code locally, download Love2d version 12.0+ [here](https://nightly.link/love2d/love/workflows/main/main). 

Make sure the command `love` exists in your path.

From vscode, use the run task. Or, enter `love .` from the project root folder.

## Deploy to Mobile Devices

### Android

1. Edit app/build.gradle


### iOS

1. Open **ios/platform/xcode/love.xcodeproj** in Xcode
2. From the **love-ios** build target under *Signing & Capabilities*,
    - Select your development team
    - Set a unique bundle identifier
3. From the **love-ios** build target under *General*,
    - Set a Display Name

4. From the xcassets catalog replace the images in **iOS AppIcon**.

5. Package your app's code using VSCode's build *package* task or run `scripts/package`

6. Build and deploy to your iOS device.
