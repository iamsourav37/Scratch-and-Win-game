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

  List<String> itemArray;
  int luckyNumbers;

  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) {
      return "empty";
    });
    // another way to do this
    // itemArray = List<String>.generate(25, (index) => "empty" );
    randomNumberGenerator();
  }

  // TODO: Random number generator
  randomNumberGenerator(){
    int random = Random().nextInt(25);
    debugPrint("Random Number is : $random");
    setState(() {
        this.luckyNumbers = random;
    });
  }


  // TODO: Getting the images method
  AssetImage getImage(int index){
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
            return lucky;    
      case "unlucky":
            return unLucky;
    }
    return circle;
  }


//  TODO: reset the game method
  resetGame(){
    setState(() {
      this.itemArray = List<String>.filled(25, "empty");
      this.randomNumberGenerator();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and Win"),
      ),
      body: Container(),
    );
  }
}
