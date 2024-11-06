import 'package:flutter/material.dart';
import 'package:mobileseventh/choice.dart';


class SignUpPage extends StatelessWidget {
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 197, 100, 214),
        
        
      ),

       bottomNavigationBar: BottomAppBar(
        height: 70,
        color: const Color.fromARGB(255, 219, 154, 231),
      ),
      body:Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50), 
          Text('Email', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color:  Color.fromARGB(255, 197, 100, 214),

          )
          ),
         TextFormField(
          style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Email';
              }
              return null;
            },
          ),
           SizedBox(height: 30),
           Text('Password', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
             color:  Color.fromARGB(255, 197, 100, 214),

          )
          
          ),
         TextFormField(
          
          style: TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Password';
              }
              return null;
            },
          ),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              child: Text('Sign up', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 154, 231),), 
              onPressed: () {
               
                if (_formKey.currentState!.validate()) {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => choice()),
                  );
                }
              },
             
            ),
          ),

        ],
      ),
    ),
      
    );
  }
}
