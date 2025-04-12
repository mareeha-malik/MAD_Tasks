import 'package:flutter/material.dart';

void main() {
  runApp(PlantShopApp());
}

class PlantShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                      _buildTextField(Icons.lock, "Password", obscureText: true),
                      _buildTextField(Icons.lock, "Confirm Password", obscureText: true),
                      SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PlantListScreen()),
                            );
                          },
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
                              fontSize: 22,
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

  Widget _buildTextField(IconData icon, String hint, {bool obscureText = false}) {
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
            borderSide: BorderSide(color: Colors.white54),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class PlantListScreen extends StatelessWidget {
  final List<Map<String, String>> plants = [
    {"name": "Ficus", "price": "\$20", "image": "assets/plant1.jpg"},
    {"name": "Cactus", "price": "\$15", "image": "assets/plant2.jpg"},
    {"name": "Samantha", "price": "\$18", "image": "assets/plant3.jpg"},
    {"name": "Aloe Vera", "price": "\$22", "image": "assets/plant3.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        actions: [Icon(Icons.shopping_cart, color: Colors.black)],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What Kind Of Plants You Want",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Search...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: plants.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantDetailScreen(plant: plants[index]),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.green[100],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(plants[index]["image"]!, height: 120, fit: BoxFit.cover),
                          SizedBox(height: 10),
                          Text(plants[index]["name"]!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(plants[index]["price"]!, style: TextStyle(color: Colors.green, fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlantDetailScreen extends StatelessWidget {
  final Map<String, String> plant;

  PlantDetailScreen({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plant["name"]!)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(plant["image"]!, height: 250),
            SizedBox(height: 10),
            Text(plant["name"]!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(plant["price"]!, style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text("Buy Now"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
