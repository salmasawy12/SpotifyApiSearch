import 'package:flutter/material.dart';
import 'package:mobileseventh/customwidget.dart';
import 'spotify.dart';
import 'spotifysong.dart';


class choice extends StatefulWidget {
  const choice({super.key});

  @override
  State<choice> createState() => _choiceState();
}

class _choiceState extends State<choice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 219, 154, 231),
      ),
       bottomNavigationBar: BottomAppBar(
        height: 70,
        color: const Color.fromARGB(255, 219, 154, 231),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           customwidget(label1: 'Search by artist', label2: 'Search by song', onPressed1: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => spotify()),
                  );}, onPressed2: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => spotifysong()),
                  );})
          
         ],
        ),
      ),
    );
  }
}