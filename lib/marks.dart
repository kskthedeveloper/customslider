import 'package:flutter/material.dart';

class Marks extends StatefulWidget {
  @override
  _MarksState createState() => _MarksState();
}

class _MarksState extends State<Marks> {
  List<int> test = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  @override
  Widget build(BuildContext context) {
    return Column(
        children: test
            .map((i) => Container(
                  width: 10.0,
                  height: 10.0,
                  color: Colors.blue,
                ))
            .toList());
  }
}
