import 'package:dio/dio.dart';
import 'package:terabayt_uz/data/source/remote/response/categories_response.dart';

import '../response/post_response.dart';

/// Creator : Azimjon Makhmudov
/// Date : 2/15/2023 Time : 01:49
/// Project : terabayt_uz
/// Package : lib/data/source/remote/api

class AppApi {
  final Dio _dio;

  AppApi(this._dio) {}

  Future<List<Categories>> getCategories() async {
    final response = await _dio.get("api.php?action=categories");
    final list = response.data as List;
    return list.map((e) => Categories.fromJson(e)).toList();
  }

  Future<List<Post>> getPosts(int categoryId) async {
    final response = await _dio.get("api.php?action=posts&first_update=1613122152&last_update=0&category=$categoryId");
    final list = response.data as List;
    return list.map((e) => Post.fromJson(e)).toList();
  }
}
