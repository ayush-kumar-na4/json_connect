import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:json_connect/controllers/post_controller.dart';
import 'package:json_connect/models/app_data.dart';
import 'package:json_connect/screens/post_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PostController controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    final appData = AppData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts", style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      backgroundColor: const Color.fromARGB(221, 166, 211, 193),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            itemCount: appData.posts.length,
            itemBuilder: (context, index) {
              final post = appData.posts[index];
              return _postCard(
                body: post.body,
                title: post.title,
                ontap: () {
                  Get.to(PostDetailsScreen(postId: post.id));
                },
              );
            },
          );
        }
      }),
    );
  }
}

Widget _postCard({
  required final String body,
  required final String title,
  required final VoidCallback ontap,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    margin: EdgeInsets.all(12),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 5),
              child: Icon(Icons.label_important_outline_rounded),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(body),
              ),
            ),
          ],
        ),
        Divider(height: 2),
        InkWell(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          onTap: ontap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Icon(Icons.info_outline_rounded, size: 15),
                SizedBox(width: 15),
                Text("See Details/Comment", style: TextStyle(fontSize: 12)),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 10),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
