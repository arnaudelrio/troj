# troj
A new Flutter + Rust project to code a tic-tac-toe game.

It is build with a flutter frontend and a rust backend, using the flutter_rust_bridge utility.

The main logic is written in rust and in the `rust/src/` folder, and the flutter interface is in `lib/main.dart`.

Using the `flutter_rust_bridge` utility, rust code is converted to `.dart`files (under the `lib/src/rust/` folder).

To update the rust code to access the methods from flutter, you need the `flutter_rust_bridge_codegen` utility, with the subcommand `generate`.
