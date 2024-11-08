import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(Project());

class Project extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF0A0E21),
          )),
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Lottie.asset(
          'assets/spotify.json',
          fit: BoxFit.fill, // Ensures the animation covers the whole screen
          repeat: false,
          onLoaded: (composition) {
            // Delay for 2 seconds instead of waiting for the full animation duration
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const homepage()),
              );
            });
          },
        ),
      ),
    );
  }
}
