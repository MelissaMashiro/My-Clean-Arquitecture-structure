import 'package:flutter/material.dart';

class SoccerBoardScreen extends StatefulWidget {
  const SoccerBoardScreen({Key? key}) : super(key: key);

  @override
  State<SoccerBoardScreen> createState() => _SoccerBoardScreenState();
}

class _SoccerBoardScreenState extends State<SoccerBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HOLITAS DEL MAR'),
      ),
    );
  }
}