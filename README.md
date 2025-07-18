# troj
A new Flutter + Rust project to code a tic-tac-toe game.

It is built with a Flutter frontend and a Rust backend, using the [flutter_rust_bridge](https://github.com/fzyzcjy/flutter_rust_bridge) utility for seamless FFI integration.

The main game logic, including board state and win condition checks, is implemented in Rust and located in the `rust/src/` folder. The Flutter interface, which handles user interaction and UI rendering, is in `lib/main.dart`.

Using `flutter_rust_bridge`, Rust functions are exposed to Dart and generated as `.dart` files under the `lib/src/rust/` folder. This allows you to call Rust logic directly from Flutter widgets.

To update the Dart bindings after modifying Rust code, use the `flutter_rust_bridge_codegen` utility with the `generate` subcommand:
```
cargo install flutter_rust_bridge_codegen
flutter_rust_bridge_codegen generate
```

To build the app with a custom launcher icon, run:
1. `flutter pub get`
2. `flutter pub run flutter_launcher_icons`
3. `flutter build apk`
