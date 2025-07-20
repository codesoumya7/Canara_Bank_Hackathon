/*import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B41), // Dark purple background
      appBar: AppBar(
        backgroundColor: const Color(0xFF292B73), // Darker bluish-purple
        title: const Text("Secure Bank Dashboard", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Hello, John Doe 👋",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 25),
            _mockAccountCard(),
            const SizedBox(height: 30),
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            _actionButton(
              context,
              icon: Icons.attach_money,
              label: "High-Value Transfer",
              onPressed: () => Navigator.pushNamed(context, '/high-value-transfer'),
            ),
            const SizedBox(height: 12),
            _actionButton(
              context,
              icon: Icons.swap_horiz,
              label: "Regular Transfer",
              onPressed: () {},
            ),
            const SizedBox(height: 30),
            const Text(
              "Recent Alerts",
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            _mockBehaviorLogs(),
          ],
        ),
      ),
    );
  }

  Widget _mockAccountCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Account Number",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 6),
          Text(
            "** 2431",
            "** 2431",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            "Current Balance",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 6),
          Text(
            "₹89,260",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3D348B),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
      ),
      icon: Icon(icon, size: 22),
      label: Text(label, style: const TextStyle(fontSize: 16)),
      onPressed: onPressed,
    );
  }

  Widget _mockBehaviorLogs() {
    return Card(
      color: const Color(0xFF2C2F7A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.amberAccent),
        title: const Text(
          "Typing speed anomaly detected",
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          "Detected during last transaction",
          style: TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
        onTap: () {},
      ),
    );
  }
}*/


/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B41),
      appBar: AppBar(
        title: const Text("Welcome Back, Soumya!"),
        backgroundColor: const Color(0xFF252658),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login'); // Or your login route
            },
          )
        ],
      ),
        body: GestureDetector(
          onPanUpdate: _handleGesture,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Summary Card
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Account Balance",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 8),
                  Text("₹ 1,20,000.00",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("A/C: XXXX XXXX 2345",
                      style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Quick Actions Grid
            const Text(
              "Quick Actions",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildActionTile(context, Icons.send, "Transfer", "/transfer"),
                _buildActionTile(context, Icons.receipt, "Pay Bills", "/dummy"),
                _buildActionTile(context, Icons.history, "History", "/dummy"),
                _buildActionTile(context, Icons.credit_card, "Cards", "/dummy"),
                _buildActionTile(context, Icons.health_and_safety, "Insurance", "/dummy"),
                _buildActionTile(context, Icons.miscellaneous_services, "Service Req", "/dummy"),
                _buildActionTile(context, Icons.trending_up, "Investments", "/dummy"),
                _buildActionTile(context, Icons.notifications, "Notifications", "/dummy"),
                _buildActionTile(context, Icons.settings, "Settings", "/dummy"),
                _buildActionTile(context,Icons.fingerprint,"Typing Setup","/typing-setup")
              ],
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/login");
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF252658),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
        ],
      ),
    );
  }

  static Widget _buildActionTile(
      BuildContext context, IconData icon, String label, String route) {
    return InkWell(
      onTap: () {
        if (route != "/dummy") {
          Navigator.pushNamed(context, route);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2B6A),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 10),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],

        ),
      ),
    );
  }
}*/



/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Offset> _gesturePoints = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B41),
      appBar: AppBar(
        title: const Text("Welcome Back, Soumya!"),
        backgroundColor: const Color(0xFF252658),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: GestureDetector(
        onPanUpdate: _handleGesture,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Summary
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Account Balance",
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                    SizedBox(height: 8),
                    Text("₹ 1,20,000.00",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("A/C: XXXX XXXX 2345",
                        style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Quick Actions
              const Text(
                "Quick Actions",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _buildActionTile(context, Icons.send, "Transfer", "/transfer"),
                  _buildActionTile(context, Icons.receipt, "Pay Bills", "/dummy"),
                  _buildActionTile(context, Icons.history, "History", "/dummy"),
                  _buildActionTile(context, Icons.credit_card, "Cards", "/dummy"),
                  _buildActionTile(context, Icons.health_and_safety, "Insurance", "/dummy"),
                  _buildActionTile(context, Icons.miscellaneous_services, "Service Req", "/dummy"),
                  _buildActionTile(context, Icons.trending_up, "Investments", "/dummy"),
                  _buildActionTile(context, Icons.notifications, "Notifications", "/dummy"),
                  _buildActionTile(context, Icons.settings, "Settings", "/dummy"),
                  _buildActionTile(context, Icons.fingerprint, "Typing Setup", "/typing-setup"),
                ],
              ),

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF252658),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
        ],
      ),
    );
  }

  // --- Gesture Detection ---
  void _handleGesture(DragUpdateDetails details) {
    _gesturePoints.add(details.localPosition);

    if (_gesturePoints.length > 30) {
      _gesturePoints.removeAt(0);
    }

    if (_gesturePoints.length >= 15 && _isCircleGesture(_gesturePoints)) {
      _gesturePoints.clear();
      _triggerLogout();
    }
  }

  bool _isCircleGesture(List<Offset> points) {
    final center = points.reduce((a, b) => a + b) / points.length.toDouble();
    final distances = points.map((p) => (p - center).distance).toList();
    final avgDist = distances.reduce((a, b) => a + b) / distances.length;
    final variance = distances
        .map((d) => pow(d - avgDist, 2))
        .reduce((a, b) => a + b) /
        distances.length;

    return variance < 500; // threshold: tweak if needed
  }

  void _triggerLogout() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Secret gesture detected. Logging out..."),
        backgroundColor: Colors.redAccent,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 1500));
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  // --- Quick Action Builder ---
  static Widget _buildActionTile(
      BuildContext context, IconData icon, String label, String route) {
    return InkWell(
      onTap: () {
        if (route != "/dummy") {
          Navigator.pushNamed(context, route);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2B6A),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 10),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'dart:async';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Offset> _gesturePoints = [];

  // Session Timer Variables
  Timer? _sessionTimer;
  int _sessionSeconds = 0;
  final int _maxSessionSeconds = 240;

  @override
  void initState() {
    super.initState();
    _startSessionTimer();
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    super.dispose();
  }

  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _sessionSeconds++;
      });

      if (_sessionSeconds >= _maxSessionSeconds) {
        _logoutDueToInactivity();
      }
    });
  }

  void _logoutDueToInactivity() async {
    _sessionTimer?.cancel();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Session timed out. Logging out..."),
        backgroundColor: Colors.orangeAccent,
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  String _formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$mins:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text("Welcome Back, Soumya!"),
        backgroundColor: const Color(0xFF80ABFF),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: GestureDetector(
        onPanUpdate: _handleGesture,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🕒 Session Timer
              Center(
                child: Text(
                  "Session Time: ${_formatTime(_sessionSeconds)}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),

              // Account Summary
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD371EF), Color(0xFFA100FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Account Balance",
                        style: TextStyle(color: Colors.white70, fontSize: 14)),
                    SizedBox(height: 8),
                    Text("₹ 1,20,000.00",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("A/C: XXXX XXXX 2345",
                        style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Quick Actions
              const Text(
                "Quick Actions",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _buildActionTile(
                      context, Icons.send, "Transfer", "/transfer"),
                  _buildActionTile(
                      context, Icons.receipt, "Pay Bills", "/dummy"),
                  _buildActionTile(context, Icons.history, "History", "/dummy"),
                  _buildActionTile(
                      context, Icons.credit_card, "Cards", "/dummy"),
                  _buildActionTile(
                      context, Icons.health_and_safety, "Insurance", "/dummy"),
                  _buildActionTile(
                      context, Icons.miscellaneous_services, "Service Req",
                      "/dummy"),
                  _buildActionTile(
                      context, Icons.trending_up, "Investments", "/dummy"),
                  _buildActionTile(
                      context, Icons.notifications, "Notifications", "/dummy"),
                  _buildActionTile(
                      context, Icons.settings, "Settings", "/dummy"),
                  _buildActionTile(context, Icons.fingerprint, "Typing Setup",
                      "/typing-setup"),
                ],
              ),
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF252658),
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
        ],
      ),
    );
  }

  // --- Gesture Detection ---
  void _handleGesture(DragUpdateDetails details) {
    _gesturePoints.add(details.localPosition);

    if (_gesturePoints.length > 30) {
      _gesturePoints.removeAt(0);
    }

    if (_gesturePoints.length >= 15 && _isCircleGesture(_gesturePoints)) {
      _gesturePoints.clear();
      _triggerLogout();
    }
  }

  bool _isCircleGesture(List<Offset> points) {
    final center = points.reduce((a, b) => a + b) / points.length.toDouble();
    final distances = points.map((p) => (p - center).distance).toList();
    final avgDist = distances.reduce((a, b) => a + b) / distances.length;
    final variance = distances
        .map((d) => pow(d - avgDist, 2))
        .reduce((a, b) => a + b) /
        distances.length;

    return variance < 500;
  }

  void _triggerLogout() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Secret gesture detected. Logging out..."),
        backgroundColor: Colors.redAccent,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 1500));
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  static Widget _buildActionTile(BuildContext context, IconData icon,
      String label, String route) {
    return InkWell(
      onTap: () {
        if (route != "/dummy") {
          Navigator.pushNamed(context, route);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2B6A),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 10),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

