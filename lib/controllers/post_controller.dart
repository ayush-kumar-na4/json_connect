import 'package:get/get.dart';
import 'package:json_connect/api/api_service.dart';
import 'package:json_connect/models/app_data.dart';

class PostController extends GetxController {
  RxBool isLoading = true.obs;
  var errorMessage = ''.obs;

  final ApiServices api = ApiServices();
  final AppData data = AppData();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAllData();
  }

  Future<void> loadAllData() async {
    try {
      isLoading(true);
      errorMessage('');
      // add data 
      data.posts = await api.fetchPosts();
      data.comments = await api.fetchComments();
      data.users = await api.fetchUsers();
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }


}
