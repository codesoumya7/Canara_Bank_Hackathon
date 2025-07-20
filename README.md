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
