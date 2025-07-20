// lib/screens/ProfileScreen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>?> _fetchBehaviorData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      return doc.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B41),
      appBar: AppBar(
        title: const Text("My Behavior Data"),
        backgroundColor: const Color(0xFF252658),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchBehaviorData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("No behavior data found.",
                  style: TextStyle(color: Colors.white)),
            );
          }

          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoTile("Typing Speed",
                    "${(data['typingSpeed'] ?? 0).toStringAsFixed(2)} chars/min"),
                _infoTile("Latitude", "${data['latitude'] ?? 'N/A'}"),
                _infoTile("Longitude", "${data['longitude'] ?? 'N/A'}"),
                _infoTile("Login Time", "${data['loginTime'] ?? 'N/A'}"),
                _infoTile("Network Type", "${data['networkType'] ?? 'N/A'}"),
                _infoTile("Wi-Fi Name", "${data['wifiNetwork'] ?? 'N/A'}"),
                _infoTile("Scroll Speed", "${data['scrollSpeed'] ?? 'N/A'}"),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}