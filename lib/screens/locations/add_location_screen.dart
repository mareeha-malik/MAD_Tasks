import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../models/location_model.dart';
import '../../services/location_service.dart';
import '../../services/database_helper.dart';

class AddLocationScreen extends StatefulWidget {
  final int userId;
  final Location? location;

  const AddLocationScreen({
    Key? key,
    required this.userId,
    this.location,
  }) : super(key: key);

  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  final dbHelper = DatabaseHelper.instance;
  late LocationService locationService;

  @override
  void initState() {
    super.initState();
    locationService = LocationService(dbHelper);

    if (widget.location != null) {
      _nameController.text = widget.location!.name;
      _descriptionController.text = widget.location!.description;
      if (widget.location!.imagePath != null) {
        _image = File(widget.location!.imagePath!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location == null ? 'Add Location' : 'Edit Location'),
        actions: [
          if (widget.location != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteLocation,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Location Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!, height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _getImage(ImageSource.camera),
                    child: const Text('Take Photo'),
                  ),
                  ElevatedButton(
                    onPressed: () => _getImage(ImageSource.gallery),
                    child: const Text('Choose from Gallery'),
                  ),
                  if (_image != null)
                    ElevatedButton(
                      onPressed: _removeImage,
                      child: const Text('Remove Image'),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveLocation,
                child: const Text('Save Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  Future<void> _saveLocation() async {
    if (_formKey.currentState!.validate()) {
      final location = Location(
        id: widget.location?.id,
        userId: widget.userId,
        name: _nameController.text,
        description: _descriptionController.text,
        imagePath: _image?.path,
      );

      try {
        if (widget.location == null) {
          await locationService.addLocation(location);
        } else {
          await locationService.updateLocation(location);
        }
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving location: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _deleteLocation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Location'),
        content: const Text('Are you sure you want to delete this location?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && widget.location != null) {
      try {
        await locationService.deleteLocation(widget.location!.id!);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting location: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}