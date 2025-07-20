class TypingAnalysisService {
  static double calculateTypingSpeed(List<DateTime> timestamps) {
    if (timestamps.length < 2) return 0;

    final start = timestamps.first;
    final end = timestamps.last;
    final duration = end.difference(start).inMilliseconds / 1000;
    final speed = (timestamps.length - 1) / duration; // chars per second
    return speed;
  }
}