import 'package:flutter/material.dart';
import 'package:task_1/login_signup.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/locations/location_list_screen.dart';
import 'screens/profile_screen.dart';
import 'models/user_model.dart';
import 'services/auth_service.dart';
import 'services/database_helper.dart';
import 'utils/database_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize database before running app
    await DatabaseInitializer.initialize();
    runApp(const MyApp());
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Initialization failed: $e'),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remember the Location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Start with AuthWrapper as home
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final dbHelper = DatabaseHelper.instance;
  late AuthService authService;
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    authService = AuthService(dbHelper);
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _checkAuth();
    setState(() => _isLoading = false);
  }

  Future<void> _checkAuth() async {
    try {
      final user = await authService.getCurrentUser();
      if (user != null) {
        setState(() => _currentUser = user);
      }
    } catch (e) {
      debugPrint('Auth check error: $e');
    }
  }

  void _handleLogin(User user) {
    setState(() => _currentUser = user);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _currentUser == null
        ? RegisterScreen(onLogin: _handleLogin)
        : MainApp(user: _currentUser!);
  }
}

class MainApp extends StatefulWidget {
  final User user;

  const MainApp({Key? key, required this.user}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          LocationListScreen(userId: widget.user.id!),
          ProfileScreen(user: widget.user),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}