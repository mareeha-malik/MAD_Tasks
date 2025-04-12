import 'package:flutter/material.dart';
import 'dart:io';
import '../../models/location_model.dart';
import '../utils/constants.dart';

class LocationCard extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  const LocationCard({
    Key? key,
    required this.location,
    required this.onTap,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            children: [
              _buildImage(context),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (location.description?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          location.description!,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: location.imagePath != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        child: Image.file(
          File(location.imagePath!),
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      )
          : Icon(
        Icons.location_on,
        size: 30,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}