

/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  int failedAttempts = 0;
  bool isLocked = false;

  Future<void> _login() async {
    setState(() {
      errorMessage = null;
    });

    if (isLocked) {
      setState(() {
        errorMessage = "Account locked after 3 failed attempts.";
      });
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/dashboard');
    } on FirebaseAuthException catch (e) {
      setState(() {
        failedAttempts++;
        if (failedAttempts >= 3) {
          isLocked = true;
          errorMessage = "Account locked after 3 failed attempts.";
        } else {
          errorMessage = e.message ?? "Login failed.";
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = "Unexpected error occurred.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Deep purple/blue
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to SecureBank",
                style: TextStyle(
                  color: Colors.pinkAccent.shade100,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.pinkAccent),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent.shade100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.pinkAccent),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent.shade100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent.shade100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent.shade100,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              if (failedAttempts > 0 && !isLocked)
                Text(
                  "Failed attempts: $failedAttempts",
                  style: const TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  int failedAttempts = 0;
  bool isLocked = false;

  Future<void> _login() async {
    setState(() {
      errorMessage = null;
    });

    if (isLocked) {
      setState(() {
        errorMessage = "Account locked after 3 failed attempts.";
      });
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/dashboard');
    } on FirebaseAuthException catch (e) {
      setState(() {
        failedAttempts++;
        if (failedAttempts >= 3) {
          isLocked = true;
          errorMessage = "Account locked after 3 failed attempts.";
        } else {
          errorMessage = e.message ?? "Login failed.";
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = "Unexpected error occurred.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Column(
              children: [
                Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX_hmzD_VPDSvRPoK5MpRlLvC_Jh41Xrv3c2wxsi8WErzbs7hJt77gNUOfuuzCyBpKgO4&usqp=CAU', height: 80),
                const SizedBox(height: 10),
                Text(
                  "CanCan Bank Demo ",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.pinkAccent.shade100,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hi Soumya 👋",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildQuickPayOptions(),
            const SizedBox(height: 20),
            _buildLoginCard(),
            const SizedBox(height: 30),
            _buildSupportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF23234B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.shade100.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Email"),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Password"),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          if (failedAttempts > 0 && !isLocked)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Failed attempts: $failedAttempts",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.pinkAccent),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pinkAccent.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildQuickPayOptions() {
    final items = [
      {'icon': Icons.phone_android, 'label': 'Mobile No'},
      {'icon': Icons.account_balance, 'label': 'Bank A/C'},
      {'icon': Icons.qr_code_2, 'label': 'My QR'},
      {'icon': Icons.receipt, 'label': 'Pay Bill'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((item) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.shade100.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(item['icon'] as IconData, size: 30, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 8),
            Text(
              item['label'] as String,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.white24),
        const SizedBox(height: 10),
        const Text(
          "Need Help?",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text(
          "📞 1800-425-0018 (Toll-free)\n📞 +91-80-22221559\n📧 support@canarabank.com",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
      ],
    );
  }
}
