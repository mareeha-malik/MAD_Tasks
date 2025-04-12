import 'package:flutter/material.dart';
import 'dart:io';
import '../../models/location_model.dart';

class LocationDetailScreen extends StatelessWidget {
  final Location location;

  const LocationDetailScreen({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(location.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (location.imagePath != null)
              Center(
                child: Image.file(
                  File(location.imagePath!),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              location.name,
              // style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            if (location.description != null && location.description!.isNotEmpty)
              Text(location.description!),
          ],
        ),
      ),
    );
  }
}