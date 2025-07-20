import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class TypingAuthSetupScreen extends StatefulWidget {
  const TypingAuthSetupScreen({super.key});

  @override
  _TypingAuthSetupScreenState createState() => _TypingAuthSetupScreenState();
}

class _TypingAuthSetupScreenState extends State<TypingAuthSetupScreen> {
  final String prompt = "The quick brown fox jumps over the lazy dog.";
  List<int> keyPressTimestamps = [];
  TextEditingController _controller = TextEditingController();

  double scrollSpeed = 0;
  double? latitude;
  double? longitude;
  String? networkName;
  DateTime loginTime = DateTime.now();

  final ScrollController _scrollController = ScrollController();
  double _lastOffset = 0;
  DateTime? _lastScrollTime;

  @override
  void initState() {
    super.initState();
    _initializeBehaviorTracking();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _initializeBehaviorTracking() async {
    await _getLocation();
    await _getNetworkInfo();
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
      latitude = locData.latitude ?? 0;
      longitude = locData.longitude ?? 0;
    }
  }

  Future<void> _getNetworkInfo() async {
    final info = NetworkInfo();
    networkName = await info.getWifiName();
  }

  void _onScroll() {
    final now = DateTime.now();
    final currentOffset = _scrollController.offset;

    if (_lastScrollTime != null) {
      final timeDiff = now.difference(_lastScrollTime!).inMilliseconds;
      final offsetDiff = (currentOffset - _lastOffset).abs();
      if (timeDiff > 0) {
        scrollSpeed = offsetDiff / timeDiff;
      }
    }

    _lastScrollTime = now;
    _lastOffset = currentOffset;
  }

  void _onTextChanged(String value) {
    keyPressTimestamps.add(DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _submitTypingData() async {
    if (keyPressTimestamps.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please type the full sentence.")),
      );
      return;
    }

    List<int> intervals = [];
    for (int i = 1; i < keyPressTimestamps.length; i++) {
      intervals.add(keyPressTimestamps[i] - keyPressTimestamps[i - 1]);
    }

    final avgInterval = intervals.reduce((a, b) => a + b) / intervals.length;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'typingSpeed': avgInterval,
      'scrollSpeed': scrollSpeed,
      'latitude': latitude ?? 0,
      'longitude': longitude ?? 0,
      'loginTime': loginTime.toIso8601String(),
      'wifiNetwork': networkName ?? "Unknown"
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Behavioral profile saved!")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B41),
      appBar: AppBar(
        title: const Text("Typing Behavior Setup"),
        backgroundColor: const Color(0xFF252658),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          controller: _scrollController,
          children: [
            const SizedBox(height: 20),
            Text(
              prompt,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2D2F61),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                onChanged: _onTextChanged,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Type the above sentence...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitTypingData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C5FEF),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
              ),
              child: const Text(
                "Save Typing Pattern",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}