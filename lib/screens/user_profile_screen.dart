import 'package:flutter/material.dart';
import 'package:json_connect/models/app_data.dart';

class UserProfileScreen extends StatelessWidget {
  final int userId;

  UserProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    final user = AppData().getUserById(userId);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("User Profile")),
        body: Center(child: Text("User not found.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

          height: 350,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            color: const Color.fromARGB(255, 167, 248, 234),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Icon(Icons.person_2, size: 55),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _labelAnsInfo("Name", user.name),
                    _labelAnsInfo("Username", user.username),
                    _labelAnsInfo("Email", user.email),
                    _labelAnsInfo("Phone", user.phone),
                    _labelAnsInfo("Website", user.website),
                    _labelAnsInfo(
                      "Address",
                      "${user.address.street}, ${user.address.city}, ${user.address.zipcode}",
                    ),
                    _labelAnsInfo(
                      "Company",
                      "${user.company.name} - ${user.company.catchPhrase}",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelAnsInfo(String label, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(info)),
        ],
      ),
    );
  }
}
