import 'package:flutter/material.dart';
import 'package:task_1/Assignment_3/Profile.dart';
import 'package:task_1/Assignment_3/home.dart';
import 'package:task_1/Assignment_3/signIn.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign Up now",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please fill the form and create account",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(height: 50.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
            SizedBox(height: 24.0),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              TextButton(
                onPressed: () {},
                child: Text(
                  'Password must be 8 charachters long',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ]),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(vertical: 23, horizontal: 160),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PopularPlaces()));
              },
              child: Text('Sign Up',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Text('Or connect with'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.facebook_outlined,
                    color: Colors.blue,
                    size: 40,
                  ),
                  onPressed: () {
                    // Handle Facebook login
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.message,
                    color: Colors.blue,
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
