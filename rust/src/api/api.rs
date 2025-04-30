use super::game::{Cell, GameTurn, Player};
use flutter_rust_bridge::frb;

#[frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[frb(sync)]
pub fn switch_fn(cell: Cell) -> Cell {
    cell.switch_fn()
}

#[frb(sync)]
pub fn make_move(cell: Cell, turn: Player) -> Cell {
    cell.make_move(turn).unwrap_or(cell)
}

#[frb(sync)]
pub fn switch_turn(turn: Player) -> Player {
    match turn {
        Player::X => Player::O,
        Player::O => Player::X,
    }
}

#[frb(sync)]
pub fn new_game() -> GameTurn {
    GameTurn::new()
}

#[frb(sync)]
pub fn check_if_full(game_turn: GameTurn) -> bool {
    game_turn.check_if_full()
}

#[frb(sync)]
pub fn check_winner(game_turn: GameTurn) -> Option<Player> {
    game_turn.check_winner()
}
