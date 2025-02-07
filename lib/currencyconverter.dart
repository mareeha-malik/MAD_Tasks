// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const CurrencyConverterApp());
// }
//
// class CurrencyConverterApp extends StatelessWidget {
//   const CurrencyConverterApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CurrencyConverterScreen(),
//     );
//   }
// }
//
// class CurrencyConverterScreen extends StatefulWidget {
//   const CurrencyConverterScreen({super.key});
//
//   @override
//   _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
// }
//
// class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
//   final TextEditingController _controller = TextEditingController();
//   double _convertedAmount = 0.0;
//   static const double exchangeRate = 280.0;
//
//   void _convertCurrency() {
//     double dollars = double.tryParse(_controller.text) ?? 0.0;
//     setState(() {
//       _convertedAmount = dollars * exchangeRate;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(title: const Text("Dollar to PKR Converter")),
//       backgroundColor: Colors.grey[800],
//       body: Padding(
//
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//
//               controller: _controller,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: "Enter amount in USD",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _convertCurrency,
//               child: const Text("Convert"),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "Equivalent in PKR: $_convertedAmount",
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Splash screen ka import karo

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  double _convertedAmount = 0.0;
  static const double exchangeRate = 280.0;

  void _convertCurrency() {
    double dollars = double.tryParse(_controller.text) ?? 0.0;
    setState(() {
      _convertedAmount = dollars * exchangeRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dollar to PKR Converter"), backgroundColor:Colors.transparent),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "assets/2.png",  // Make sure this image is in your assets folder
            fit: BoxFit.cover,
          ),
          // Content
          Center(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                // color: Colors.black.withOpacity(0.6), // Semi-transparent background
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Enter amount in USD",
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _convertCurrency,
                    child: const Text("Convert"),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Equivalent in PKR: $_convertedAmount",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
