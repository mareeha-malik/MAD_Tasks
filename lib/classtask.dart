import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widgets Demo'),
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
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Container
              Container(
                color: Colors.blue,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Container Widget',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Left'),
                  Text('Right'),
                ],
              ),

              SizedBox(height: 16),

              // Column
              Column(
                children: [
                  Text('Top'),
                  Text('Bottom'),
                ],
              ),

              SizedBox(height: 16),

              // Stack
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.red,
                    width: 200,
                    height: 100,
                  ),
                  Text('Stack Overlay'),
                ],
              ),

              SizedBox(height: 16),

              // ListView (inside a Container to limit height)
              Container(
                height: 100,
                child: ListView(
                  children: [
                    ListTile(title: Text('List Item 1')),
                    ListTile(title: Text('List Item 2')),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // GridView (inside a Container to limit height)
              Container(
                height: 200,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    4,
                        (index) => Container(
                      color: Colors.green,
                      margin: EdgeInsets.all(8),
                      child: Center(child: Text('Grid Item $index')),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // ElevatedButton
              ElevatedButton(
                onPressed: () {},
                child: Text('ElevatedButton'),
              ),

              SizedBox(height: 16),

              // TextField
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 16),

              // Image
              Image.asset(
                'assets/logo.png',
                height: 100,
                width: 100,
              ),

              SizedBox(height: 16),

              // Card
              Card(
                elevation: 5,
                child: ListTile(
                  title: Text('Card Title'),
                  subtitle: Text('Card Subtitle'),
                ),
              ),

              SizedBox(height: 16),

              // Slider
              Slider(
                value: 0.5,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}