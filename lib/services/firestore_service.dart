import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/listing_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Listing>> getAllListings() {
    return _firestore.collection('listings').orderBy('timestamp', descending: true).snapshots().map((snap) => snap.docs.map((doc) => Listing.fromMap(doc.data(), doc.id)).toList());
  }

  Stream<List<Listing>> getUserListings(String uid) {
    return _firestore.collection('listings').where('createdBy', isEqualTo: uid).snapshots().map((snap) => snap.docs.map((doc) => Listing.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addListing(Listing listing) async {
    await _firestore.collection('listings').add(listing.toMap());
  }

  Future<void> updateListing(String id, Listing listing) async {
    await _firestore.collection('listings').doc(id).update(listing.toMap());
  }

  Future<void> deleteListing(String id) async {
    await _firestore.collection('listings').doc(id).delete();
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return doc.data() as Map<String, dynamic>?;
  }

  Future<void> updateNotificationPreference(String uid, bool enabled) async {
    await _firestore.collection('users').doc(uid).update({'notificationsEnabled': enabled});
  }
}