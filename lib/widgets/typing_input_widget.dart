import 'package:flutter/material.dart';
import '../services/typing_analysis_service.dart';

class TypingInputWidget extends StatefulWidget {
  const TypingInputWidget({super.key});

  @override
  State<TypingInputWidget> createState() => _TypingInputWidgetState();
}

class _TypingInputWidgetState extends State<TypingInputWidget> {
  final TextEditingController _controller = TextEditingController();
  List<DateTime> _timestamps = [];

  void _onTextChanged(String value) {
    _timestamps.add(DateTime.now());
  }

  void _analyze() {
    final speed = TypingAnalysisService.calculateTypingSpeed(_timestamps);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Typing speed: ${speed.toStringAsFixed(2)} chars/sec"),
    ));
    _timestamps.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: _onTextChanged,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Reason",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _analyze,
          child: const Text("Analyze Typing Speed"),
        ),
      ],
    );
  }
}