import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MoneyTransferScreen extends StatefulWidget {
  const MoneyTransferScreen({super.key});

  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController paragraphController = TextEditingController();

  DateTime? typingStartTime;
  double typingSpeed = 0.0;
  double latitude = 0.0;
  double longitude = 0.0;
  String networkType = "";
  String loginTime = "";
  List<String> mismatchReasons = [];

  @override
  void initState() {
    super.initState();
    _initializeEnvData();
  }

  Future<void> _initializeEnvData() async {
    await _getLocation();
    await _getNetworkType();
    loginTime = DateTime.now().toIso8601String();
  }

  Future<void> _getLocation() async {
    final location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (permissionGranted == PermissionStatus.granted) {
      final locData = await location.getLocation();
      latitude = locData.latitude ?? 0.0;
      longitude = locData.longitude ?? 0.0;
    }
  }

  Future<void> _getNetworkType() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      networkType = "WiFi";
    } else if (result == ConnectivityResult.mobile) {
      networkType = "Mobile";
    } else {
      networkType = "None";
    }
  }

  void _startTypingTimer() {
    typingStartTime = DateTime.now();
  }

  void _endTypingAndCalculateSpeed() {
    final endTime = DateTime.now();
    final duration = endTime.difference(typingStartTime ?? endTime).inMilliseconds;
    final textLength = paragraphController.text.length;
    if (duration > 0 && textLength > 0) {
      typingSpeed = textLength / (duration / 1000);
    }
  }

  Future<Map<String, dynamic>> _fetchStoredBehaviorData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!doc.exists) throw Exception("Behavior data not found");

    return doc.data()!;
  }

  int _calculateMismatches(Map<String, dynamic> stored) {
    int mismatches = 0;
    mismatchReasons.clear();

    if ((stored['latitude'] - latitude).abs() > 0.02 || (stored['longitude'] - longitude).abs() > 0.02) {
      mismatches++;
      mismatchReasons.add("Location Mismatch");
    }

    if ((stored['typingSpeed'] - typingSpeed).abs() > 10) {
      mismatches++;
      mismatchReasons.add("Typing Speed Mismatch");
    }

    if ((stored['networkType'] as String).toLowerCase() != networkType.toLowerCase()) {
      mismatches++;
      mismatchReasons.add("Network Type Mismatch");
    }

    if ((DateTime.parse(stored['loginTime']).hour - DateTime.parse(loginTime).hour).abs() > 2) {
      mismatches++;
      mismatchReasons.add("Login Time Mismatch");
    }

    return mismatches;
  }

  void _handleTransferValidation() async {
    _endTypingAndCalculateSpeed();

    try {
      final storedData = await _fetchStoredBehaviorData();
      final mismatches = _calculateMismatches(storedData);

      if (mismatches == 0) {
        _showSuccessDialog("All behavior matches. Transfer allowed!");
      } else {
        _showMismatchSummaryDialog(mismatches);
      }
    } catch (e) {
      _showError("Validation failed: $e");
    }
  }

  void _showMismatchSummaryDialog(int mismatches) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("⚠️ Behavior Mismatches Detected"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$mismatches mismatches found:"),
            const SizedBox(height: 10),
            ...mismatchReasons.map((e) => Text("• $e")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (mismatches <= 2) {
                _showSecurityQuestionDialog();
              } else {
                _showBiometricAuthDialog();
              }
            },
            child: const Text("Proceed"),
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("✅ Transfer Verified"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _showSecurityQuestionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Security Question"),
        content: const Text("What is the name of your first pet?"),
        actions: [
          TextField(decoration: const InputDecoration(hintText: "Answer")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog("Answer correct. Transfer allowed.");
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }

  void _showBiometricAuthDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Biometric Authentication"),
        content: const Text("Too many mismatches. Please verify your identity using biometrics."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showError("Biometric failed. Account locked.");
            },
            child: const Text("Authenticate"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transfer Money")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: accountController,
              decoration: const InputDecoration(
                labelText: "Receiver Account Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: remarksController,
              decoration: const InputDecoration(
                labelText: "Remarks (Optional)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            const Text("Please type the following to verify your identity:"),
            const Text(
              "The quick brown fox jumps over the lazy dog.",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: paragraphController,
              onTap: _startTypingTimer,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Start typing here...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _handleTransferValidation,
              child: const Text("Validate & Transfer"),
            ),
          ],
        ),
      ),
    );
  }
}
