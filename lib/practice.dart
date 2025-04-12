import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mids Practice',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Practice(),
    );
  }
}

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mids Practice',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.headphones),
              title: Text('Item 1'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            Divider(height: 16.0, indent: 16, endIndent: 16, color: Colors.grey),
            ListTile(
              leading: Icon(Icons.headphones),
              title: Text('Item 2'),
              trailing: Icon(Icons.arrow_forward),
            ),
            Divider(height: 16.0, indent: 16, endIndent: 16, color: Colors.grey),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ Fixed Stack with Proper Positioning
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 30, left: 120, right: 100),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                  ),
                  child: Column(
                    children: [
                      Text("1st child",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.redAccent)),
                      SizedBox(height: 20),
                      Text("2nd Child",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 138,
                  child: Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text("text",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(height: 16.0, indent: 16, endIndent: 16, color: Colors.grey),
            SizedBox(height: 20),

            // ✅ Row with Expanded Images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex: 1, child: Image.asset("assets/vulture.png")),
                Expanded(flex: 2, child: Image.asset("assets/Unicoen.png")),
                Expanded(flex: 1, child: Image.asset("assets/Whale.png")),
              ],
            ),

            SizedBox(height: 20),

            // ✅ Circular Image with Border
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
                image: DecorationImage(
                  image: AssetImage("assets/vulture.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 20),

            // ✅ Elevated Button Fix
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: Text('ElevatedButton',
                  style: TextStyle(color: Colors.white)),
            ),

            SizedBox(height: 20),

            // ✅ Card with ListView inside a Constrained Container
            Card(
              elevation: 5,
              child: Container(
                height: 200,
                width: 250,// Constraining ListView
                child: Column(
                  children: [
                    SizedBox(height:10,),
                    Image.asset("assets/vulture.png",height: 100,),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        SizedBox(width: 20,),
                        Text("5 stars review")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
