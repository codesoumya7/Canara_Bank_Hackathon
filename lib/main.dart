/*import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking App - Secure Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthScreen(),
      routes: {
        '/touch': (context) => TouchHomePage(),
      },
    );
  }
}

// 🔐 Login Page (No Signup)
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> _login() async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate on successful login
      Navigator.pushReplacementNamed(context, '/touch');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'Login failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bank Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

// 🔵 Dummy Gesture Page
class TouchHomePage extends StatefulWidget {
  @override
  _TouchHomePageState createState() => _TouchHomePageState();
}

class _TouchHomePageState extends State<TouchHomePage> {
  String _gestureDetected = 'No gesture detected';

  void _updateGesture(String gesture) {
    setState(() {
      _gestureDetected = gesture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Touch Gesture Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const AuthScreen()));
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => _updateGesture('Tap Detected'),
        onLongPress: () => _updateGesture('Long Press (simulated pressure)'),
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            _updateGesture('Swiping Right');
          } else if (details.delta.dx < 0) {
            _updateGesture('Swiping Left');
          }
        },
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue.shade100,
            alignment: Alignment.center,
            child: Text(
              _gestureDetected,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/high_value_txn_screen.dart';
import 'screens/typing_auth_setup_screen.dart';
import 'screens/ProfileScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Banking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF121212), // Optional: dark background
        fontFamily: 'Roboto', // Optional: modern clean font
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const AuthScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/transfer': (context) => const HighValueTxnScreen(),
        '/typing-setup':(context)=>const TypingAuthSetupScreen(),
        '/profile':(context)=>const ProfileScreen(),
        // You can add more routes as your app grows
      },
    );
  }
}


