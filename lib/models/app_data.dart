import 'package:json_connect/models/comment_model.dart';
import 'package:json_connect/models/post_model.dart';
import 'package:json_connect/models/user_model.dart';

class AppData {
  // Singleton pattern setup
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;
  AppData._internal();

  // Cached data
  List<PostModel> posts = [];
  List<CommentModel> comments = [];
  List<UserModel> users = [];

  // Helper: Get a user by userId
  UserModel? getUserById(int id) {
    try {
      return users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null; // User not found
    }
  }

  // Helper: Get comments for a specific post
  List<CommentModel> getCommentsByPostId(int postId) {
    return comments.where((comment) => comment.postId == postId).toList();
  }

  // Helper: Get a post by ID (optional)
  PostModel? getPostById(int postId) {
    try {
      return posts.firstWhere((post) => post.id == postId);
    } catch (e) {
      return null;
    }
  }

  // ✅ Optional: Clear cached data (e.g. on logout or refresh)
  void clearAll() {
    posts.clear();
    comments.clear();
    users.clear();
  }
}
