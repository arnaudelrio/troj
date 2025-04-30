use flutter_rust_bridge::frb;

#[derive(Clone, Copy, PartialEq)]
#[frb(sync)]
pub enum Player {
    X,
    O,
}

#[derive(Clone, Copy, PartialEq)]
#[frb(sync)]
pub enum Cell {
    Empty,
    Filled(Player),
}

#[derive(Clone, PartialEq)]
#[frb(sync)]
pub struct GameTurn {
    #[frb(sync)]
    pub board: Vec<Vec<Cell>>,
    #[frb(sync)]
    pub turn: Player,
}

impl Cell {
    pub fn switch_fn(self) -> Self {
        if self == Cell::Empty {
            return Cell::Filled(Player::X);
        } else if self == Cell::Filled(Player::X) {
            return Cell::Filled(Player::O);
        } else {
            return Cell::Empty;
        }
    }

    pub fn make_move(mut self, turn: Player) -> Result<Self, &'static str> {
        if self != Cell::Empty {
            return Err("Invalid move: cell already filled!");
        }
        self = Cell::Filled(turn);
        Ok(self)
    }
}

impl GameTurn {
    pub fn new() -> Self {
        Self {
            board: vec![
                vec![Cell::Empty, Cell::Empty, Cell::Empty],
                vec![Cell::Empty, Cell::Empty, Cell::Empty],
                vec![Cell::Empty, Cell::Empty, Cell::Empty],
            ],
            turn: Player::X,
        }
    }

    pub fn check_if_full(&self) -> bool {
        for game in (*self.board).into_iter() {
            for cell in game {
                if *cell == Cell::Empty {
                    return false;
                }
            }
        }
        true
    }

    pub fn check_winner(&self) -> Option<Player> {
        for i in 0..3 {
            if self.board[i][0] == self.board[i][1] && self.board[i][1] == self.board[i][2] {
                if let Cell::Filled(player) = self.board[i][0] {
                    return Some(player);
                }
            }
            if self.board[0][i] == self.board[1][i] && self.board[1][i] == self.board[2][i] {
                if let Cell::Filled(player) = self.board[0][i] {
                    return Some(player);
                }
            }
        }
        if self.board[0][0] == self.board[1][1] && self.board[1][1] == self.board[2][2] {
            if let Cell::Filled(player) = self.board[0][0] {
                return Some(player);
            }
        }
        if self.board[0][2] == self.board[1][1] && self.board[1][1] == self.board[2][0] {
            if let Cell::Filled(player) = self.board[0][2] {
                return Some(player);
            }
        }
        None
    }
}
