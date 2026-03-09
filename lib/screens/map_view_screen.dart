import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/listing_model.dart';
import '../providers/listing_provider.dart';

class MapViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListingProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(title: Text('Map View'), backgroundColor: Color(0xFF111328)),
      body: StreamBuilder<List<Listing>>(
        stream: provider.getAllListingsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          List<Listing> listings = snapshot.data ?? [];
          final markers = listings.map((l) => Marker(
            markerId: MarkerId(l.id),
            position: LatLng(l.lat, l.lng),
            infoWindow: InfoWindow(title: l.name),
          )).toSet();

          if (markers.isEmpty) return Center(child: Text('No listings to show', style: TextStyle(color: Colors.white)));

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(listings.first.lat, listings.first.lng),
              zoom: 12,
            ),
            markers: markers,
          );
        },
      ),
    );
  }
}