import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  static Future<File?> pickImageFromGallery() async {
    return await pickImage(ImageSource.gallery);
  }

  static Future<File?> pickImageFromCamera() async {
    return await pickImage(ImageSource.camera);
  }

  static Future<String?> saveImagePermanently(File image) async {
    try {
      // In a real app, you might want to save to application documents directory
      // and generate a unique filename
      return image.path;
    } catch (e) {
      print('Error saving image: $e');
      return null;
    }
  }

  static Future<void> deleteImageFile(String? imagePath) async {
    if (imagePath != null) {
      try {
        final file = File(imagePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        print('Error deleting image: $e');
      }
    }
  }
}

// Helper function to use directly without class instantiation
Future<File?> pickImage(ImageSource source) async {
  return await ImagePickerHelper.pickImage(source);
}