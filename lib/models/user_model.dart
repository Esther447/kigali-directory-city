import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final bool notificationsEnabled;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    this.notificationsEnabled = false,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data, String uid) {
    return UserProfile(
      uid: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      notificationsEnabled: data['notificationsEnabled'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'notificationsEnabled': notificationsEnabled,
    };
  }
}
