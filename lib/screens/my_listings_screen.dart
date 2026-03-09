import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/listing_model.dart';
import '../providers/listing_provider.dart';
import '../providers/auth_provider.dart';
import 'add_edit_listing_screen.dart';
import 'listing_detail_screen.dart';

class MyListingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final provider = Provider.of<ListingProvider>(context);
    final uid = auth.user?.uid ?? '';

    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(
        title: Text('My Listings'),
        backgroundColor: Color(0xFF111328),
      ),
      body: StreamBuilder<List<Listing>>(
        stream: provider.getUserListingsStream(uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          List<Listing> listings = snapshot.data ?? [];
          if (listings.isEmpty) return Center(child: Text('No listings yet', style: TextStyle(color: Colors.white)));
          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (_, index) {
              final item = listings[index];
              return Card(
                color: Color(0xFF111328),
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.location_on, color: Color(0xFFFFB300)),
                  title: Text(item.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(item.category, style: TextStyle(color: Colors.white70)),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                    onSelected: (value) async {
                      if (value == 'edit') {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditListingScreen(listing: item)));
                      } else if (value == 'delete') {
                        final confirm = await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Confirm Delete'),
                            content: Text('Are you sure you want to delete this listing?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
                              TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Delete')),
                            ],
                          ),
                        );
                        if (confirm ?? false) {
                          provider.deleteListing(item.id);
                        }
                      }
                    },
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListingDetailScreen(listing: item))),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFB300),
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditListingScreen())),
      ),
    );
  }
}