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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
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
  late bool win;

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
        gameTurn.board[row][col] = makeMove(cell: gameTurn.board[row][col], turn: turn);
        turn = switchTurn(turn: turn);
      }
      if (checkIfFull(gameTurn: gameTurn)) {
        text = "No more places!";
        win = true;
      };
      Player? winner = checkWinner(gameTurn: gameTurn);
      if (winner != null) {
        text = "Player ${winner == Player.x ? 'X' : 'O'} wins!";
        win = true;
      };
    });
  }

  Widget _buildCell(int row, int col) {
    final cell = gameTurn.board[row][col];
    String symbol = ' ';
    Color? symbolColor;
    if (cell == Cell_Filled(Player.x)) {
      symbol = 'X';
      symbolColor = Colors.deepPurple;
    } else if (cell == Cell_Filled(Player.o)) {
      symbol = 'O';
      symbolColor = Colors.orange[700];
    }

    return GestureDetector(
      onTap: () => _handleTap(row, col),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 90,
        height: 90,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.deepPurple.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: symbolColor ?? Colors.grey[400],
              letterSpacing: 2,
            ),
            child: Text(symbol),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TROJ', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Turn: ${turn == Player.x ? 'X' : 'O'}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: turn == Player.x ? Colors.deepPurple : Colors.orange[700],
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int row = 0; row < 3; row++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int col = 0; col < 3; col++)
                              _buildCell(row, col),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedOpacity(
                  opacity: text.isNotEmpty ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: win
                          ? (text.contains("wins") ? Colors.green[100] : Colors.orange[100])
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: win
                            ? (text.contains("wins") ? Colors.green[900] : Colors.orange[900])
                            : Colors.deepPurple,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      gameTurn = newGame();
                      turn = Player.x;
                      text = "";
                      win = false;
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
