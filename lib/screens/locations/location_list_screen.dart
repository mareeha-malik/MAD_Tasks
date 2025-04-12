import 'dart:io';

import 'package:flutter/material.dart';
import '../../models/location_model.dart';
import '../../services/location_service.dart';
import '../../services/database_helper.dart';
import 'add_location_screen.dart';
import 'location_detail_screen.dart';

class LocationListScreen extends StatefulWidget {
  final int userId;

  const LocationListScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _LocationListScreenState createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  final dbHelper = DatabaseHelper.instance;
  late LocationService locationService;
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    locationService = LocationService(dbHelper);
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final loadedLocations = await locationService.getLocations(widget.userId);
    setState(() {
      locations = loadedLocations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remembered Locations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddLocationScreen(userId: widget.userId),
                ),
              );
              if (result == true) {
                _loadLocations();
              }
            },
          ),
        ],
      ),
      body: locations.isEmpty
          ? const Center(child: Text('No locations saved yet.'))
          : ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return ListTile(
            title: Text(location.name),
            subtitle: location.description != null && location.description!.isNotEmpty
                ? Text(location.description!)
                : null,
            leading: location.imagePath != null
                ? Image.file(File(location.imagePath!), width: 50, height: 50, fit: BoxFit.cover)
                : const Icon(Icons.location_on),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationDetailScreen(location: location),
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLocationScreen(
                      userId: widget.userId,
                      location: location,
                    ),
                  ),
                );
                if (result == true) {
                  _loadLocations();
                }
              },
            ),
          );
        },
      ),
    );
  }
}