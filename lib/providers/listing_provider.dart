import 'package:flutter/material.dart';
import '../models/listing_model.dart';
import '../services/firestore_service.dart';

class ListingProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Listing> _allListings = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';

  String get selectedCategory => _selectedCategory;

  List<Listing> get filteredListings {
    return _allListings.where((listing) {
      bool matchesSearch = listing.name.toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesCategory = _selectedCategory == 'All' || listing.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void updateListings(List<Listing> listings) {
    _allListings = listings;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Stream<List<Listing>> getAllListingsStream() {
    return _firestoreService.getAllListings();
  }

  Stream<List<Listing>> getUserListingsStream(String uid) {
    return _firestoreService.getUserListings(uid);
  }

  Future<void> addListing(Listing listing) async {
    await _firestoreService.addListing(listing);
  }

  Future<void> updateListing(String id, Listing listing) async {
    await _firestoreService.updateListing(id, listing);
  }

  Future<void> deleteListing(String id) async {
    await _firestoreService.deleteListing(id);
  }
}