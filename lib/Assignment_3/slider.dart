import 'package:flutter/material.dart';
import 'package:task_1/Assignment_3/signup.dart';

class SliderScreen extends StatelessWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroSlider(),
      routes: {
        // '/': (context) => SliderScreen(),
        // '/home': (context) =>  HomeScreen(),
        '/signup': (context) =>  SignUpPage(),
      },
    );
  }
}

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/splash_1.png',
      'title1': 'Life is short and the',
      'title2': 'world is',
      'highlight': 'wide',
      'description': 'At Friends tours and travel, we customize reliable and trustworthy educational tours to destinations all over the world.',
    },
    {
      'image': 'assets/splash_2.png',
      'title1': 'Its a big world out',
      'title2': 'there go',
      'highlight': 'explore',
      'description': 'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
    },
    {
      'image': 'assets/splash_3.png',
      'title1': 'People dont take trips,',
      'title2': 'trips take',
      'highlight': 'people',
      'description': 'Book your next trip and experience the beauty of the world with us!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return IntroPage(
                image: _pages[index]['image']!,
                title1: _pages[index]['title1']!,
                title2: _pages[index]['title2']!,
                highlight: _pages[index]['highlight']!,
                description: _pages[index]['description']!,
              );
            },
          ),

          Positioned(
            bottom: 130,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                    (index) => Container(
                  width: _currentPage == index ? 12 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: _currentPage == 0
                ? ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
                : Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 20),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Intro Page Widget
class IntroPage extends StatelessWidget {
  final String image;
  final String title1;
  final String title2;
  final String highlight;
  final String description;

  const IntroPage({
    super.key,
    required this.image,
    required this.title1,
    required this.title2,
    required this.highlight,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // Image section
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Text section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: title1 + '\n'),
                          TextSpan(
                            text: title2 + ' ',
                            style: const TextStyle(fontSize: 28,fontWeight:FontWeight.bold),
                          ),
                          TextSpan(
                            text: highlight,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Description
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                  ],

                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
