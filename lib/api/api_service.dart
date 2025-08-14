import 'package:dio/dio.dart';
import 'package:json_connect/models/comment_model.dart';
import 'package:json_connect/models/post_model.dart';
import 'package:json_connect/models/user_model.dart';

class ApiServices {
  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
      headers: {'Content-type': 'application/json'},
    ),
  );

  //fetch posts
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _dio.get('/posts');

      final List<PostModel> postsList =
          (response.data as List)
              .map((jsonPost) => PostModel.fromJson(jsonPost))
              .toList();

      return postsList;
    } on DioException catch (e) {
      throw Exception('Failed to fetch Posts: ${e.message}');
    }
  }

  //fetch comments
  Future<List<CommentModel>> fetchComments() async {
    try {
      final response = await _dio.get('/comments');

      final List<CommentModel> commentsList =
          (response.data as List)
              .map((jsonComment) => CommentModel.fromJson(jsonComment))
              .toList();

      return commentsList;
    } on DioException catch (e) {
      throw Exception('Failed to fetch Comments: ${e.message}');
    }
  }

  //fetch Users
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _dio.get('/users');

      final List<UserModel> usersList =
          (response.data as List)
              .map((jsonUser) => UserModel.fromJson(jsonUser))
              .toList();

      return usersList;
    } on DioException catch (e) {
      throw Exception('Failed to fetch Users data: ${e.message}');
    }
  }

  //post data
  Future<PostModel> createPost(String title, String body, int userId) async {
    try {
      final response = await _dio.post(
        '/posts',
        data: {'title': title, 'body': body, 'userId': userId},
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
      );
      return PostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create post: ${e.message}');
    }
  }
}
