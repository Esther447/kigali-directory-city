import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/listing_model.dart';
import '../providers/listing_provider.dart';
import 'listing_detail_screen.dart';

class DirectoryScreen extends StatefulWidget {
  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Hospital', 'Police', 'Library', 'Restaurant', 'Cafe', 'Park', 'Tourist Attraction'];
  
  // Filter listings based on search and category

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListingProvider>(context);
    provider.setSearchQuery(searchQuery);
    provider.setCategory(selectedCategory);
    

    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(
        title: Text('Kigali City Directory'),
        backgroundColor: Color(0xFF111328),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search by name...',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Color(0xFFFFB300)),
                filled: true,
                fillColor: Color(0xFF111328),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ChoiceChip(
                  label: Text(categories[index]),
                  selected: selectedCategory == categories[index],
                  selectedColor: Color(0xFFFFB300),
                  backgroundColor: Color(0xFF111328),
                  onSelected: (_) => setState(() => selectedCategory = categories[index]),
                  labelStyle: TextStyle(color: selectedCategory == categories[index] ? Colors.black : Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Listing>>(
              stream: provider.getAllListingsStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                provider.updateListings(snapshot.data!);
                final listings = provider.filteredListings;
                if (listings.isEmpty) return Center(child: Text('No listings found', style: TextStyle(color: Colors.white)));
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
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (i) => Icon(Icons.star, color: i < item.rating.round() ? Color(0xFFFFB300) : Colors.white24, size: 16)),
                        ),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListingDetailScreen(listing: item))),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}