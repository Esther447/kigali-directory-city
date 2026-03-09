import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/listing_model.dart';

class ListingDetailScreen extends StatelessWidget {
  final Listing listing;
  ListingDetailScreen({required this.listing});

  void _launchMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
    if (await canLaunch(url)) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final marker = Marker(
      markerId: MarkerId(listing.id),
      position: LatLng(listing.lat, listing.lng),
      infoWindow: InfoWindow(title: listing.name),
    );

    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(title: Text(listing.name), backgroundColor: Color(0xFF111328)),
      body: ListView(
        children: [
          Container(
            height: 250,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(listing.lat, listing.lng), zoom: 15),
              markers: {marker},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(listing.name, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Chip(label: Text(listing.category), backgroundColor: Color(0xFFFFB300)),
                SizedBox(height: 16),
                Row(children: [
                  Icon(Icons.location_on, color: Color(0xFFFFB300)),
                  SizedBox(width: 8),
                  Expanded(child: Text(listing.address, style: TextStyle(color: Colors.white70))),
                ]),
                SizedBox(height: 8),
                Row(children: [
                  Icon(Icons.phone, color: Color(0xFFFFB300)),
                  SizedBox(width: 8),
                  Text(listing.phone, style: TextStyle(color: Colors.white70)),
                ]),
                SizedBox(height: 16),
                Text('Description', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(listing.description, style: TextStyle(color: Colors.white70)),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _launchMaps(listing.lat, listing.lng),
                    child: Text('Get Directions'),
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFB300)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}