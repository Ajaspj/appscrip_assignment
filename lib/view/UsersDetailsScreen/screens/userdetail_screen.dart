import 'package:appscrip_assignment/view/UsersDetailsScreen/widgets/bottom_row.dart';

import 'package:appscrip_assignment/view/UsersDetailsScreen/widgets/user_details_card.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user['name'] ?? 'No Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: UserDetailsCard(user: user),
            ),
            const SizedBox(height: 16),
            ButtonRow(user: user),
          ],
        ),
      ),
    );
  }
}
