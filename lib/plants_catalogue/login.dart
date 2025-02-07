import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top-Centered Image
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'plant_hanging.png',
              height: 350.0,
              fit: BoxFit.contain,
            ),
          ),

          Spacer(),

          Container(
            width: double.infinity,
            height: 550,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Column(
                    children: [
                      _buildTextField(Icons.person, "Username"),
                      _buildTextField(Icons.email, "Email"),
                      _buildTextField(Icons.lock, "Password",
                          obscureText: true),
                      _buildTextField(Icons.lock, "Confirm Password",
                          obscureText: true),

                      SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity, // Make button full-width
                        height: 60, // Increase button height
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 22, // Increased text size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Text Field Function
  Widget _buildTextField(IconData icon, String hint,
      {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextField(
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white54), // Underline color
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Focused underline
          ),
        ),
      ),
    );
  }
}
