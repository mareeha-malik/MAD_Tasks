// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:task_1/home.dart';
//
// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   bool isLogin = true;
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();  final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   late Database _database;
//   bool _databaseInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeDatabase();
//   }
//
//   Future<void> _initializeDatabase() async {
//     try {
//       _database = await openDatabase(
//         join(await getDatabasesPath(), 'user_database.db'),
//         onCreate: (db, version) {
//           return db.execute(
//             'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE, email TEXT UNIQUE, password TEXT, firstName TEXT, lastName TEXT)',
//           );
//         },
//         version: 1,
//       );
//
//       setState(() {
//         _databaseInitialized = true;
//       });
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//           SnackBar(content: Text('Failed to initialize database: $e')),
//         );
//       }
//     }
//   }
//
//   Future<void> _signUp() async {
//     if (!_databaseInitialized || !_formKey.currentState!.validate()) return;
//
//     try {
//       final existingUser = await _database.query(
//         'users',
//         where: 'username = ? OR email = ?',
//         whereArgs: [_usernameController.text, _emailController.text],
//       );
//
//       if (existingUser.isNotEmpty) {
//         ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//           SnackBar(content: Text('Username or email already exists!')),
//         );
//         return;
//       }
//
//       await _database.insert(
//         'users',
//         {
//           'username': _usernameController.text.trim(),
//           'email': _emailController.text.trim(),
//           'password': _passwordController.text,
//           'firstName': _firstNameController.text.trim(),
//           'lastName': _lastNameController.text.trim(),
//         },
//       );
//
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//         SnackBar(content: Text('Sign-up successful! Please login.')),
//       );
//
//       _clearSignUpForm();
//       setState(() => isLogin = true);
//
//       Navigator.pushReplacement(
//         context as BuildContext,
//         MaterialPageRoute(builder: (context) => Feed()),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//         SnackBar(content: Text('Error during sign-up: $e')),
//       );
//     }
//   }
//
//   Future<void> _signIn() async {
//     if (!_databaseInitialized || !_formKey.currentState!.validate()) return;
//
//     try {
//       final user = await _database.query(
//         'users',
//         where: '(username = ? OR email = ?) AND password = ?',
//         whereArgs: [
//           _usernameController.text.trim(),
//           _usernameController.text.trim(),
//           _passwordController.text, // In production, compare hashes
//         ],
//       );
//
//       if (user.isNotEmpty) {
//         Navigator.pushReplacement(
//           context as BuildContext,
//           MaterialPageRoute(builder: (context) => Feed()),
//         );
//       } else {
//         ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//           SnackBar(content: Text('Invalid credentials!')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//         SnackBar(content: Text('Error during sign-in: $e')),
//       );
//     }
//   }
//
//   void _clearSignUpForm() {
//     _emailController.clear();
//     _passwordController.clear();
//     _firstNameController.clear();
//     _lastNameController.clear();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xffff8a8c), Color(0xff5871f3)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Spacer(),
//               Image.asset('logo.png', height: 120.0),
//               _buildSwitchButtons(),
//               SizedBox(height: 30),
//               Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30),
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Column(
//                       children: isLogin ? _buildLoginFields() : _buildSignUpFields(),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               _buildAuthButton(),
//               _buildSocialIcons(),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildLoginFields() {
//     return [
//       _buildTextField(
//         controller: _usernameController,
//         icon: Icons.person,
//         hint: "Username or Email",
//       ),
//       _buildTextField(
//         controller: _passwordController,
//         icon: Icons.lock,
//         hint: "Password",
//         obscureText: true,
//       ),
//     ];
//   }
//
//   List<Widget> _buildSignUpFields() {
//     return [
//       _buildTextField(
//         controller: _firstNameController,
//         icon: Icons.person,
//         hint: "First Name",
//       ),
//       _buildTextField(
//         controller: _lastNameController,
//         icon: Icons.person,
//         hint: "Last Name",
//       ),
//       _buildTextField(
//         controller: _usernameController,
//         icon: Icons.person,
//         hint: "Username",
//       ),
//       _buildTextField(
//         controller: _emailController,
//         icon: Icons.email,
//         hint: "Email",
//         keyboardType: TextInputType.emailAddress,
//       ),
//       _buildTextField(
//         controller: _passwordController,
//         icon: Icons.lock,
//         hint: "Password",
//         obscureText: true,
//       ),
//     ];
//   }
//
//   Widget _buildAuthButton() {
//     return ElevatedButton(
//       onPressed: isLogin ? _signIn : _signUp,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.purple,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//         minimumSize: Size(200, 50),
//       ),
//       child: Text(
//         isLogin ? "Login" : "Sign Up",
//         style: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 18,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSwitchButtons() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.9),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextButton(
//               onPressed: () => setState(() => isLogin = true),
//               style: TextButton.styleFrom(
//                 backgroundColor: isLogin ? Color(0xff555CFE) : Colors.transparent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: Text(
//                 "Existing",
//                 style: TextStyle(
//                   color: isLogin ? Colors.white : Color(0xff555CFE),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: TextButton(
//               onPressed: () => setState(() => isLogin = false),
//               style: TextButton.styleFrom(
//                 backgroundColor: isLogin ? Colors.transparent : Color(0xff555CFE),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               child: Text(
//                 "New User",
//                 style: TextStyle(
//                   color: isLogin ? Color(0xff555CFE) : Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required IconData icon,
//     required String hint,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: Colors.purple),
//           hintText: hint,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter $hint';
//           }
//           if (hint.toLowerCase().contains('email') && !value.contains('@')) {
//             return 'Please enter a valid email';
//           }
//           if (hint.toLowerCase().contains('password') && value.length < 6) {
//             return 'Password must be at least 6 characters';
//           }
//           return null;
//         },
//       ),
//     );
//   }
//
//   Widget _buildSocialIcons() {
//     return Padding(
//       padding: EdgeInsets.only(top: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//             icon: Icon(Icons.facebook, color: Colors.white, size: 40),
//             onPressed: () {},
//           ),
//           SizedBox(width: 20),
//           IconButton(
//             icon: Icon(Icons.chrome_reader_mode, color: Colors.white, size: 40),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     super.dispose();
//   }
// }