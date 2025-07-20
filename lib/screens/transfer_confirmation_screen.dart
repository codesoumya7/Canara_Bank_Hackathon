import 'package:flutter/material.dart';

class TransferConfirmationScreen extends StatelessWidget {
  const TransferConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accentColor = Colors.pinkAccent.shade100.withOpacity(0.3);
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: const Text(
          "Transfer Funds",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: accentColor,
                blurRadius: 15,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Transfer to:",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),
              _buildInput("Receiver Name"),
              const SizedBox(height: 15),
              _buildInput("Account Number", isNumeric: true),
              const SizedBox(height: 15),
              _buildInput("Amount", isNumeric: true),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent.shade100.withOpacity(0.5),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: const Color(0xFF1A1A2E),
                        title: const Text(
                          "Success",
                          style: TextStyle(color: Colors.white),
                        ),
                        content: const Text(
                          "Transfer completed successfully.",
                          style: TextStyle(color: Colors.white70),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              "OK",
                              style: TextStyle(color: Colors.pinkAccent),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text("Confirm Transfer"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, {bool isNumeric = false}) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent.shade100.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent.shade100),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
