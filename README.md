<p align="center">
 <img width=200px height=200px src="assets/app_icons/icon-red.png"/>
</p>

<h1 align="center"> Flower Power </h1>

<div align="center">
Flower Power is a beautifully designed, open-source application for reading comics, webtoons, and manga seamlessly across multiple platforms. Experience your favorite stories with a fresh, flower-themed aesthetic.
</div>

> [!WARNING]
> **Disclaimer**: Flower Power does not host any content. The developer(s) of this application do not have any affiliation with the content providers that are freely available on the internet. This application is an independent fork of the original open-source project and is provided as-is, strictly as a reader utility.

## Features

<div align="left">

Features include:
* Reading webtoons, comics, novels, and more.
* Local reading of content directly from your device.
* A configurable reader with multiple viewers, reading directions, and custom settings.
* Beautiful and immersive UI tailored for maximum reading comfort.
* Categories to organize your personal library.
* Light and dark themes.
* Create backups locally to read offline or sync to your desired cloud service.

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
