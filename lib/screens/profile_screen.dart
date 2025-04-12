import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/database_helper.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Address: ${user.address}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('Note: Profile cannot be updated after creation',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}