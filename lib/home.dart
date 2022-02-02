import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true;
  List<String> displayE0h = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  var myTextStyle = TextStyle(color: Colors.black, fontSize: 30);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 74, left: 40, right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Player O",
                        style: myTextStyle,
                      ),
                      Text(
                        ohScore.toString(),
                        style: myTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 74, left: 40, right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Player X",
                        style: myTextStyle,
                      ),
                      Text(
                        exScore.toString(),
                        style: myTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          SizedBox(
            height: 60,
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          displayE0h[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayE0h[index] == '') {
        displayE0h[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && displayE0h[index] == '') {
        displayE0h[index] = 'X';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checWinner();
    });
  }

  void _checWinner() {
    // checks 1st row
    if (displayE0h[0] == displayE0h[1] &&
        displayE0h[0] == displayE0h[2] &&
        displayE0h[0] != '') {
      _showWinDialog(displayE0h[0]);
    }
    // checks 2st row
    if (displayE0h[3] == displayE0h[4] &&
        displayE0h[3] == displayE0h[5] &&
        displayE0h[3] != '') {
      _showWinDialog(displayE0h[3]);
    }
    // checks 3st row
    if (displayE0h[6] == displayE0h[7] &&
        displayE0h[6] == displayE0h[8] &&
        displayE0h[6] != '') {
      _showWinDialog(displayE0h[6]);
    }
    // checks 1st column
    if (displayE0h[0] == displayE0h[3] &&
        displayE0h[0] == displayE0h[6] &&
        displayE0h[0] != '') {
      _showWinDialog(displayE0h[0]);
    }
    // checks 2st column
    if (displayE0h[1] == displayE0h[4] &&
        displayE0h[1] == displayE0h[7] &&
        displayE0h[1] != '') {
      _showWinDialog(displayE0h[1]);
    }
    // checks 3st column
    if (displayE0h[2] == displayE0h[5] &&
        displayE0h[2] == displayE0h[8] &&
        displayE0h[2] != '') {
      _showWinDialog(displayE0h[2]);
    }
    // checks diagonal
    if (displayE0h[6] == displayE0h[4] &&
        displayE0h[6] == displayE0h[2] &&
        displayE0h[6] != '') {
      _showWinDialog(displayE0h[6]);
    }
    // checks diagonal
    if (displayE0h[0] == displayE0h[4] &&
        displayE0h[0] == displayE0h[8] &&
        displayE0h[0] != '') {
      _showWinDialog(displayE0h[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("DRAW"),
            actions: [
              FlatButton(
                child: Text("Play Again!"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("WINNER IS :" + winner),
            actions: [
              FlatButton(
                child: Text("Play Again!"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });

    if (winner == 'O') {
      ohScore += 1;
    } else if (winner == 'X') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayE0h[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
