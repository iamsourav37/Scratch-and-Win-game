import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage lucky = AssetImage('images/rupee.png');
  AssetImage unLucky = AssetImage('images/sadFace.png');

  int remainingAttempts;
  bool isPlayable;

  List<String> itemArray;
  int luckyNumbers;

  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) {
      return "empty";
    });
    this.remainingAttempts = 5;
    this.isPlayable = true;
    // another way to do this
    // itemArray = List<String>.generate(25, (index) => "empty" );
    randomNumberGenerator();
  }

  // TODO: Random number generator
  randomNumberGenerator() {
    int random = Random().nextInt(25);
    debugPrint("Random Number is : $random");
    setState(() {
      this.luckyNumbers = random;
    });
  }

  // TODO: Getting the images method
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
      case "unlucky":
        return unLucky;
    }
    return circle;
  }

// TODO: play game method

  playGame(int index) {
    if (remainingAttempts == 0) {
        this.isPlayable = false;
        return;
    }

    if (luckyNumbers == index) {
      setState(() {
        itemArray[index] = "lucky";
        this.isPlayable = false;
        this.remainingAttempts--;
      });
    } else {
      setState(() {
        itemArray[index] = "unlucky";
        this.remainingAttempts--;
      });
    }
  }

  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumbers] = "lucky";
      this.remainingAttempts = 0;
      this.isPlayable = false;
    });
  }

//  TODO: reset the game method
  resetGame() {
    setState(() {
      this.itemArray = List<String>.filled(25, "empty");
      this.randomNumberGenerator();
      this.remainingAttempts = 5;
      this.isPlayable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text("Scratch and Win game"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: this.itemArray.length,
                itemBuilder: (context, index) => SizedBox(
                  height: 40,
                  width: 50,
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      if (this.isPlayable)
                        this.playGame(index);
                      else {}
                    },
                    child: Image(image: this.getImage(index)),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 10),
              child: Center(
                child: Text(
                  "Attempt remainings : ${this.remainingAttempts}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: RaisedButton(
                onPressed: () {
                  this.showAll();
                },
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.pinkAccent,
                child: Text(
                  "Show all",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: RaisedButton(
                onPressed: () {
                  this.resetGame();
                },
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.pink,
                child: Text(
                  "Reset Game",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Colors.black,
              height: 30,
              child: Center(
                child: Text(
                  "LearnCodeOnline.in",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
