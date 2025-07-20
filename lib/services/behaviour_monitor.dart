behaviour-monitor.dart
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';

class BehaviourMonitor {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  BehaviourMonitor({required this.userId});

  Future<Map<String, dynamic>> fetchBaselineData() async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
    return doc.exists ? doc.data() as Map<String, dynamic> : {};
  }

  Future<String> getNetworkType() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) return "Mobile";
    if (result == ConnectivityResult.wifi) return "WiFi";
    return "None";
  }

  Future<String?> getWifiName() async {
    final info = NetworkInfo();
    return await info.getWifiName();
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<Map<String, dynamic>> monitorCurrentBehaviour({
    required double currentTypingSpeed,
    required double currentScrollSpeed,
  }) async {
    Map<String, dynamic> baseline = await fetchBaselineData();

    String networkType = await getNetworkType();
    String? wifiName = await getWifiName();
    Position position = await getCurrentLocation();
    DateTime now = DateTime.now();

    // Basic distance check (replace with a threshold later)
    double distance = Geolocator.distanceBetween(
      baseline['latitude'] ?? 0,
      baseline['longitude'] ?? 0,
      position.latitude,
      position.longitude,
    );

    // Time deviation in hours
    DateTime baselineTime = DateTime.tryParse(baseline['login_time'] ?? '') ?? now;
    double timeDiff = now.difference(baselineTime).inHours.toDouble();

    bool typingFlag = (currentTypingSpeed - (baseline['typing_speed'] ?? 0)).abs() > 10;
    bool scrollFlag = (currentScrollSpeed - (baseline['scroll_speed'] ?? 0)).abs() > 10;
    bool locationFlag = distance > 500; // meters
    bool timeFlag = timeDiff > 2;
    bool networkFlag = wifiName != (baseline['network_name'] ?? '');

    int flagsRaised = [
      typingFlag,
      scrollFlag,
      locationFlag,
      timeFlag,
      networkFlag,
    ].where((e) => e).length;

    return {
      'typingFlag': typingFlag,
      'scrollFlag': scrollFlag,
      'locationFlag': locationFlag,
      'timeFlag': timeFlag,
      'networkFlag': networkFlag,
      'flagsRaised': flagsRaised,
      'currentWifi': wifiName,
      'currentLocation': '${position.latitude}, ${position.longitude}',
      'currentTime': now.toIso8601String(),
    };
  }
}