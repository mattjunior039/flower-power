<p align="center">
 <img width=200px height=200px src="assets/app_icons/logo.svg"/>
</p>

<h1 align="center"> Flower Power </h1>

<div align="center">
Flower Power is a beautifully designed, open-source tool for parsing and rendering web media and local files across multiple platforms. Experience your favorite stories with a fresh, flower-themed aesthetic.
</div>

> [!WARNING]
> **Disclaimer**: Flower Power is an offline media utility, local library manager, and generic web parser. It does not host, provide, or link to any digital media or pre-installed extensions. All content is provided by the user. The developers have no affiliation with any third-party content providers.

## Features

<div align="left">

* Read locally imported .cbz, .epub, and .pdf files directly from your device.
* Extensible architecture: load user-defined plugins to parse and render media from your preferred web sources.
* A configurable reader with multiple viewers, reading directions, and custom settings.
* Beautiful and immersive UI tailored for maximum reading comfort.
* Categories to organize your personal library.
* Light and dark themes.
* Create local backups to read offline or sync to your desired cloud service.

</div>

## Download
Get the app from our [releases page](https://github.com/mattjunior039/flower-power/releases).

# Contributing

Contributions to Flower Power are welcome! 

## Using flutter_rust_bridge

To run and build this app, you need to have [Flutter SDK](https://docs.flutter.dev/get-started/install) and [Rust toolchain](https://www.rust-lang.org/tools/install) installed on your system.

```bash
rustc --version
flutter doctor
```

You also need to have the CLI tool for flutter_rust_bridge ready:

```bash
cargo install 'flutter_rust_bridge_codegen'
```

Generate the Rust bindings:

```bash
flutter_rust_bridge_codegen generate
```

Now you can run and build this app just like any other Flutter project:

```bash
flutter run
```

## License

    Copyright 2023 Moustapha Kodjo Amadou (Original Work)
    Copyright 2026 Flower Power Contributors (Modifications)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

### iOS Installation (Sideloading)
Because Flower Power is not listed on the App Store, you can easily sideload it onto your iPhone using a Mac.

**Method 1: Xcode (Requires Mac)**
1. Open the `ios/Runner.xcworkspace` file in Xcode.
2. Go to **Xcode > Settings > Accounts** and add your Apple ID.
3. Select the **Runner** project in the left sidebar, click the **Signing & Capabilities** tab, and select your Apple ID as the Team.
4. Plug in your iPhone, select it from the device dropdown at the top, and press the **Play** button to install.
*(Note: With a free developer account, the app will expire after 7 days. You will need to plug your phone back in and hit Play again to refresh it.)*

**Method 2: AltStore / Sideloadly**
Compile the app into an `.ipa` file (`flutter build ipa`) and use tools like AltStore or Sideloadly to wirelessly install and automatically refresh the app on your phone every 7 days.
