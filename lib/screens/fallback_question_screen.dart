import 'package:flutter/material.dart';
import 'transfer_confirmation_screen.dart';

class FallbackQuestionsScreen extends StatefulWidget {
  const FallbackQuestionsScreen({super.key});

  @override
  State<FallbackQuestionsScreen> createState() => _FallbackQuestionsScreenState();
}

class _FallbackQuestionsScreenState extends State<FallbackQuestionsScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _petController = TextEditingController();
  final TextEditingController _flowerController = TextEditingController();

  final String storedNickname = 'rashi';
  final String storedPet = 'bruno';
  final String storedFlower = 'rose';

  void _verifyAnswers() {
    if (_nicknameController.text.trim().toLowerCase() == storedNickname &&
        _petController.text.trim().toLowerCase() == storedPet &&
        _flowerController.text.trim().toLowerCase() == storedFlower) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TransferConfirmationScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade400,
          content: const Text(
            "Incorrect answers. Please try again.",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Center(
        child: Card(
          elevation: 12,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: const Color(0xFF16213E),
          shadowColor: Colors.pinkAccent.shade100.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Security Questions",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent.shade100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nicknameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Nickname",
                      labelStyle: TextStyle(color: Colors.pinkAccent.shade100),
                      prefixIcon: Icon(Icons.person_outline, color: Colors.pinkAccent.shade100),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent.shade100),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent.shade100, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _petController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Pet's Name",
                      labelStyle: TextStyle(color: Colors.pinkAccent.shade100),
                      prefixIcon: Icon(Icons.pets, color: Colors.pinkAccent.shade100),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent.shade100),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent.shade100, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _flowerController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Favorite Flower",
                      labelStyle: TextStyle(color: Colors.pinkAccent.shade100),
                      prefixIcon: Icon(Icons.local_florist, color: Colors.pinkAccent.shade100),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent.shade100),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pinkAccent.shade100, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent.shade100,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _verifyAnswers,
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}