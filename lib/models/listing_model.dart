import 'package:cloud_firestore/cloud_firestore.dart';

class Listing {
  final String id;
  final String name;
  final String category;
  final String address;
  final String phone;
  final String description;
  final double lat;
  final double lng;
  final String createdBy;
  final DateTime timestamp;
  final double rating;

  Listing({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.phone,
    required this.description,
    required this.lat,
    required this.lng,
    required this.createdBy,
    required this.timestamp,
    this.rating = 4.5,
  });

  factory Listing.fromMap(Map<String, dynamic> data, String docId) {
    return Listing(
      id: docId,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      description: data['description'] ?? '',
      lat: data['lat']?.toDouble() ?? 0.0,
      lng: data['lng']?.toDouble() ?? 0.0,
      createdBy: data['createdBy'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      rating: data['rating']?.toDouble() ?? 4.5,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'address': address,
      'phone': phone,
      'description': description,
      'lat': lat,
      'lng': lng,
      'createdBy': createdBy,
      'timestamp': FieldValue.serverTimestamp(),
      'rating': rating,
    };
  }
}