

import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.body, required this.title, required this.ontap});

  final String title;
  final String body;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.label_important_outline_rounded),
            title: Text(title),
            subtitle: Text(body),
          ),
          Divider(),
          GestureDetector(

            onTap: ontap,

            child: SizedBox(
                height: 30,
                child: ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text("See Details/Comments"),
                ),
              ),
          ),
          
        ],
      ),
    );
  }
}
