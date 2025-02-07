import 'package:flutter/material.dart';

import 'homepage.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffff8a8c), Color(0xff5871f3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'logo.png',
              height: 150.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Exsisting",
                        style: TextStyle(
                            color: Color(0xff555CFE),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "New User",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: 18),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xff555CFE)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        _buildTextField(Icons.person, "username"),
                        _buildTextField(Icons.email, "Email"),
                        _buildTextField(Icons.lock, "Password",
                            obscureText: true),
                        _buildTextField(Icons.lock, "Confirm Password",
                            obscureText: true),
                      ],
                    ),
                  ),
                ),
                // SignUp Button
                SizedBox(height: 25),
                Positioned(
                  top: 300,left: 150,right:150,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                Container(height: 400,)
              ],
            )
          ],
        ),
      ),
    );
  }

  // text field function
  Widget _buildTextField(IconData icon, String hint,
      {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.purple),
            hintText: hint,
            // filled: true,
            // fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            // Padding for text

            border: UnderlineInputBorder(
              // borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.purple,
              ),
            )),
      ),
    );
  }
}
