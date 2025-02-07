import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentTime = '';

  final List<Map<String, dynamic>> apps = [
    {"icon": Icons.folder, "label": "Files"},
    {"icon": Icons.ac_unit, "label": "Freezer"},
    {"icon": Icons.camera, "label": "Camera"},
    {"icon": Icons.photo, "label": "Photos"},
    {"icon": Icons.calculate, "label": "Calculator"},
    {"icon": Icons.calendar_month, "label": "Calendar"},
  ];

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateFormat('hh:mm a').format(DateTime.now());
    });

    Timer.periodic(Duration(seconds: 60), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateFormat('hh:mm a').format(DateTime.now());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Wallpaper
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/11.jpg"), // Add this image to your assets folder
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Time Display
          Positioned(
            top: 40,
            left: 20,
            child: Text(
              _currentTime,
              style: GoogleFonts.tiltNeon(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // App Grid
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 icons per row
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                return _buildAppIcon(apps[index]["icon"], apps[index]["label"]);
              },
            ),
          ),

          // Quote at the Bottom
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Text(
              "Life goes On",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppIcon(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 50, color: Colors.white),
        SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
