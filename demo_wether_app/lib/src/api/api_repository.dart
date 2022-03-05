import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiRepository {
  final String? url;
  final Map<String, dynamic>? payload;

  ApiRepository({@required this.url, this.payload});

  final Dio _dio = Dio();

  void get({
    required Function() beforeSend,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    _dio.get(url!, queryParameters: payload).then((response) {
      debugPrint('get => responce : $response');
      onSuccess(response.data);
    }).catchError((error) {
      debugPrint('get => ERROR : $error');
    });
  }
}
