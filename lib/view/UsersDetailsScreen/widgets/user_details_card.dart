import 'package:appscrip_assignment/view/UsersDetailsScreen/widgets/detail_section.dart';
import 'package:flutter/material.dart';

class UserDetailsCard extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetailsCard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsSection(
              title: "User Info",
              details: {
                "Name": user['name'],
                "Username": user['username'],
                "Email": user['email'],
                "Phone": user['phone'],
                "Website": user['website'],
              },
            ),
            const SizedBox(height: 16),
            DetailsSection(
              title: "Address",
              details: {
                "Street": user['address']['street'],
                "Suite": user['address']['suite'],
                "City": user['address']['city'],
                "Zipcode": user['address']['zipcode'],
              },
            ),
            const SizedBox(height: 16),
            DetailsSection(
              title: "Company",
              details: {
                "Company Name": user['company']['name'],
                "Catchphrase": user['company']['catchPhrase'],
                "Business": user['company']['bs'],
              },
            ),
          ],
        ),
      ),
    );
  }
}
