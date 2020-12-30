import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoRepository {
  static final PhotoRepository _photoRepository = PhotoRepository._();
  static const int perPage = 10;

  PhotoRepository._();

  factory PhotoRepository() {
    return _photoRepository;
  }

  Future<dynamic> getPhoto({
    @required int page,
  }) async {
    try {
      return await http.get(
          'https://api.unsplash.com/photos?page=$page&per_page=$perPage&client_id=hlO4_1kMJqCnZeuHnDJH_FQ7t2EaJRr_LCPyIWKtjAw');
    } catch (e) {
      return e.toString();
    }
  }
}
