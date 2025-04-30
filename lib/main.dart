import 'package:flutter/material.dart';
import 'src/rust/api/api.dart';
import 'src/rust/api/game.dart';
import 'src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late GameTurn gameTurn;
  late Player turn;
  late String text;
  late Bool win;

  @override
  void initState() {
    super.initState();
    gameTurn = newGame();
    turn = Player.x;
    text = "";
    win = false;
  }

  void _handleTap(int row, int col) {
    setState(() {
      if (win) {
        return;
      }
      if (gameTurn.board[row][col] != Cell.empty()) {
        return;
      } else {
        // gameTurn.board[row][col] = makeMove(cell: gameTurn.board[row][col], turn: gameTurn.turn);
        gameTurn.board[row][col] = makeMove(cell: gameTurn.board[row][col], turn: turn);
        // gameTurn.turn = switchTurn(turn: gameTurn.turn);
        // gameTurn.turn = Player.o;
        turn = switchTurn(turn: turn);
      }
      if (checkIfFull(gameTurn: gameTurn)) {
        text = "No more places!";
      };
      Player? winner = checkWinner(gameTurn: gameTurn);
      if (winner != null) {
        text = "Player ${winner} wins!";
        win = true;
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('TROJ')),
        body: Column(
          children: [
            for (int row = 0; row < 3; row++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 0; col < 3; col++)
                  GestureDetector(
                    onTap: () => _handleTap(row, col),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(gameTurn.board[row][col] == Cell.empty() ? ' ' : (gameTurn.board[row][col] == Cell_Filled(Player.x) ? 'X' : 'O')),
                      ),
                    ),
                  )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Turn: ${turn == Player.x ? 'X' : 'O'}"),
                )
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(text),
                )
              ]
            ),
          ],
        ),
      ),
    );
  }
}
