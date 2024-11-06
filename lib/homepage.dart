import 'package:flutter/material.dart';
import 'package:mobileseventh/signup.dart';


class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homePageState();
}

class _homePageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 219, 154, 231),
        title: Text('Fetch',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        ),
      ),
       bottomNavigationBar: BottomAppBar(
        height: 70,
        color: const Color.fromARGB(255, 219, 154, 231),
      ),
      

      body: Center(
        child: Container(
          width: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 190), 
              Text('Welcome to Fetch, Please sign up to start!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:  Color.fromARGB(255, 197, 100, 214),
              ),
              ),

             SizedBox(height: 50), 
             ElevatedButton(
              child: Text('Sign up',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(backgroundColor:const Color.fromARGB(255, 219, 154, 231) ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}