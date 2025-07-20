# Canara_Bank_Hackathon

# 🔐 Behavior-Based Secure Mobile Banking App

A Flutter-based secure mobile banking app that uses *behavioral biometrics* to authenticate users during sensitive actions like high-value transactions. It verifies users through *typing speed, **scroll behavior, **location, **network type, and **session activity, with **two fallback layers* and a hidden gesture for distress signals.


## 📌 Features

- 🔑 Behavior-based verification (typing speed, network type, location, login time)
- 🔒 Two-level fallback authentication:
  - Level 1: Security questions (for 1–2 mismatches)
  - Level 2: Biometric/Face ID (for >2 mismatches)
- 🧠 Continuous behavior tracking across key screens
- ⏱️ 10-minute session timeout with visible timer
- 🌀 Invisible distress gesture (e.g., drawing a circle) to lock account & alert bank
- 📋 Profile screen shows real-time behavioral metadata
- ⚡ Firebase Firestore integration for secure cloud storage

## 🚀 Setup Instructions

1. Clone the Repo
git clone https://github.com/codesoumya7/Canara_Bank_Hackathon.git

2. Install Flutter Packages in the downloaded folder
flutter pub get

3. Setup Firebase
Create a Firebase project at https://console.firebase.google.com.
Add your Android app to Firebase: Use your app’s package name (e.g., com.example.behaviour_auth_app)

4. Download google-services.json and place it inside: 
android/app/google-services.json

5. Enable Firestore and Authentication in Firebase console.
6. Make sure your android/build.gradle and android/app/build.gradle files are updated for Firebase integration.
7. Run the App: flutter run
  Make sure your emulator or physical device has location & internet permissions enabled.
