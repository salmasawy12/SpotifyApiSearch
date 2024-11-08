import 'package:flutter/material.dart';

class customwidget extends StatelessWidget {
  final String label1;
  final String label2;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;

  customwidget({required this.label1, required this.label2, required this.onPressed1, required this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
        ElevatedButton(
          onPressed: onPressed1,
          child: Text(label1,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(fontSize: 18),
            backgroundColor:  Colors.green,
          ),
        ),
        ElevatedButton(
          onPressed: onPressed2,
          child: Text(label2,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(fontSize: 18),
            backgroundColor:  Colors.green,
          ),
        ),
      ],
     
    );
  }
}