import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/listing_model.dart';
import '../providers/listing_provider.dart';
import '../providers/auth_provider.dart';

class AddEditListingScreen extends StatefulWidget {
  final Listing? listing;
  AddEditListingScreen({this.listing});

  @override
  State<AddEditListingScreen> createState() => _AddEditListingScreenState();
}

class _AddEditListingScreenState extends State<AddEditListingScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController descriptionController;
  late TextEditingController latController;
  late TextEditingController lngController;

  @override
  void initState() {
    super.initState();
    final l = widget.listing;
    nameController = TextEditingController(text: l?.name ?? '');
    categoryController = TextEditingController(text: l?.category ?? '');
    addressController = TextEditingController(text: l?.address ?? '');
    phoneController = TextEditingController(text: l?.phone ?? '');
    descriptionController = TextEditingController(text: l?.description ?? '');
    latController = TextEditingController(text: l?.lat.toString() ?? '');
    lngController = TextEditingController(text: l?.lng.toString() ?? '');
  }

  void saveListing(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final provider = Provider.of<ListingProvider>(context, listen: false);
    final listing = Listing(
      id: widget.listing?.id ?? '',
      name: nameController.text,
      category: categoryController.text,
      address: addressController.text,
      phone: phoneController.text,
      description: descriptionController.text,
      lat: double.tryParse(latController.text) ?? 0,
      lng: double.tryParse(lngController.text) ?? 0,
      createdBy: widget.listing?.createdBy ?? auth.user!.uid,
      timestamp: widget.listing?.timestamp ?? DateTime.now(),
      rating: widget.listing?.rating ?? 4.5,
    );

    if (widget.listing == null) {
      provider.addListing(listing);
    } else {
      provider.updateListing(listing.id, listing);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.listing == null ? 'Add Listing' : 'Edit Listing'), backgroundColor: Color(0xFF111328)),
      backgroundColor: Color(0xFF1D1E33),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: nameController, decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.white)), style: TextStyle(color: Colors.white), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: categoryController, decoration: InputDecoration(labelText: 'Category', labelStyle: TextStyle(color: Colors.white)), style: TextStyle(color: Colors.white), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: addressController, decoration: InputDecoration(labelText: 'Address', labelStyle: TextStyle(color: Colors.white)), style: TextStyle(color: Colors.white), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone', labelStyle: TextStyle(color: Colors.white)), style: TextStyle(color: Colors.white), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description', labelStyle: TextStyle(color: Colors.white)), style: TextStyle(color: Colors.white), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: latController, decoration: InputDecoration(labelText: 'Latitude', labelStyle: TextStyle(color: Colors.white)), style: TextStyle(color: Colors.white), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: lngController, decoration: InputDecoration(labelText: 'Longitude', labelStyle: TextStyle(color: Colors.white)), style: TextStyle(color: Colors.white), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () => saveListing(context), child: Text('Save'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFB300))),
            ],
          ),
        ),
      ),
    );
  }
}