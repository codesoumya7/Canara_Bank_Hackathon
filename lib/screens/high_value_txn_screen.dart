import 'package:behaviour_auth_app/screens/transfer_confirmation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:network_info_plus/network_info_plus.dart'; // if not already
import 'fallback_question_screen.dart';
import 'account_locked_screen.dart';

class HighValueTxnScreen extends StatefulWidget {
  const HighValueTxnScreen({Key? key}) : super(key: key);

  @override
  _HighValueTxnScreenState createState() => _HighValueTxnScreenState();
}

class _HighValueTxnScreenState extends State<HighValueTxnScreen> {
  final TextEditingController _controller = TextEditingController();
  late int _startTime;
  double _scrollSpeed = 0.0;
  double _typingSpeedCPM = 0.0; // Typing speed in characters per minute
  final String paragraph =
      'The quick brown fox jumps over the lazy dog near the riverbank during sunset.';

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now().millisecondsSinceEpoch;

    _scrollController.addListener(() {
      _scrollSpeed = _scrollController.position.activity?.velocity ?? 0.0;
    });

    _controller.addListener(() {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final secondsElapsed = (currentTime - _startTime) / 1000.0;
      if (secondsElapsed > 0) {
        final characterCount = _controller.text.trim().length;
        setState(() {
          _typingSpeedCPM = (characterCount / secondsElapsed) * 60;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _checkBehavior() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!doc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No baseline data found.')),
        );
        return;
      }

      final data = doc.data()!;
      final int endTime = DateTime.now().millisecondsSinceEpoch;
      final typedText = _controller.text.trim();
      final timeTakenSeconds = (endTime - _startTime) / 1000.0;
      final characters = typedText.length;
      final typingSpeed = (characters / timeTakenSeconds) * 60; // CPM

      final position = await Geolocator.getCurrentPosition();


      final connectivity = await Connectivity().checkConnectivity();
      final info = NetworkInfo();
      String currentNetwork;

      if (connectivity == ConnectivityResult.wifi) {
        currentNetwork = await info.getWifiName() ?? "WiFi Unknown";
      } else if (connectivity == ConnectivityResult.mobile) {
        currentNetwork = "Mobile Data";
      } else {
        currentNetwork = "No Network";
      }


      int mismatchCount = 0;
      List<String> failedFeatures = [];

      // 1. Typing speed (Characters Per Minute)
      final storedTypingSpeed = (data['typingSpeed'] ?? 0).toDouble();
      if ((typingSpeed - storedTypingSpeed).abs() > 50) {
        mismatchCount++;
        failedFeatures.add("Typing Speed");
      }

      // 2. Scroll speed
      final storedScrollSpeed = (data['scrollSpeed'] ?? 0).toDouble();
      if ((_scrollSpeed - storedScrollSpeed).abs() > 20) {
        mismatchCount++;
        failedFeatures.add("Scroll Speed");
      }

      // 3. Location check
      final double lat = (data['latitude'] ?? 0).toDouble();
      final double lon = (data['longitude'] ?? 0).toDouble();
      if ((position.latitude - lat).abs() > 0.01 ||
          (position.longitude - lon).abs() > 0.01) {
        mismatchCount++;
        failedFeatures.add("Location");
      }
      String? wifiName = await info.getWifiName();
      String? wifiIP = await info.getWifiIP();
      String currentNetworkType = (wifiIP != null && wifiName != null) ? "wifi" : "mobile";

      // 4. Network match
      final storedNetworkType = (data['networkType'] ?? '').toString().toLowerCase();
      if (currentNetworkType != storedNetworkType) {
        mismatchCount++;
        failedFeatures.add("Network Type");
      }

      if (mismatchCount >= 3) {
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'locked': true,
          'lockedAt': FieldValue.serverTimestamp(),
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AccountLockedScreen()),
        );
      } else if (mismatchCount >= 1) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1A1A2E),
            title: const Text(
              "Behavior Mismatch Detected",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "The following features didn't match your usual behavior:\n\n- ${failedFeatures.join('\n- ')}",
              style: const TextStyle(color: Colors.white70),
            ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel",
                    style: TextStyle(color: Colors.pinkAccent)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent.shade100,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FallbackQuestionsScreen(),
                    ),
                  );
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Behavior verified successfully.')),
        );

        // Navigate to next screen or success action
        await Future.delayed(const Duration(milliseconds: 300)); // slight delay to show the SnackBar
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const TransferConfirmationScreen(), // ← replace with your actual destination
          ),
        );
      }

    } catch (e) {
      debugPrint("Error checking behavior: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error verifying behavior.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Verify Transaction'),
        titleTextStyle: const TextStyle(fontSize: 18, color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          controller: _scrollController,
          children: [
            Text(
              paragraph,
              style:
              TextStyle(fontSize: 16, color: Colors.pinkAccent.shade100),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                labelText: 'Type here',
                labelStyle: TextStyle(color: Colors.pinkAccent.shade100),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.pinkAccent.shade100),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.pinkAccent.shade100, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Typing Speed: ${_typingSpeedCPM.toStringAsFixed(1)} characters/min",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent.shade100,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _checkBehavior,
              child: const Text('Verify & Proceed',
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}