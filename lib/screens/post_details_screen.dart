import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_connect/models/app_data.dart';
import 'package:json_connect/models/post_model.dart';
import 'package:json_connect/models/comment_model.dart';
import 'package:json_connect/screens/user_profile_screen.dart';

class PostDetailsScreen extends StatelessWidget {
  final int postId;

  const PostDetailsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final appData = AppData();
    final PostModel? post = appData.getPostById(postId);
    final List<CommentModel> comments = appData.getCommentsByPostId(postId);

    if (post == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Post Details")),
        body: Center(child: Text("Post not found.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Details",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post title
            _post(
              body: post.body,
              title: post.title,
              ontap: () {
                Get.to(UserProfileScreen(userId: post.userId));
              },
            ),

            Divider(height: 30),

            // Comments Section
            Text(
              "Comments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return _commentsCard(
                    body: comment.body,
                    title: comment.name,
                    email: comment.email,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _post({
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
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Icon(Icons.info_outline_rounded, size: 12),
                SizedBox(width: 10),
                Text("See user's details", style: TextStyle(fontSize: 12)),
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

Widget _commentsCard({
  required final String body,
  required final String title,
  required final String email,
}) {
  return Card(
    color: Colors.blueGrey[50],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    margin: EdgeInsets.all(12),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 12),
              Icon(Icons.person_3),
              SizedBox(width: 12),
              Text(email, style: TextStyle()),
            ],
          ),
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(body, style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    ),
  );
}
