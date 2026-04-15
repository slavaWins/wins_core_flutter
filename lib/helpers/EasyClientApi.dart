import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wins_core_flutter/WinsCoreConfig.dart';
import 'package:wins_core_flutter/helpers/ToastEasy.dart';

Future<dynamic> EasyClientApi(String endpoint) async {
  try {
    String url = WinsCoreConfig.domainApi + endpoint;

    final response = await http
        .post(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer ${WinsCoreConfig.jwt}',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )
        .timeout(Duration(seconds: 10)); // Добавьте таймаут

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      dynamic isSuccess = jsonData["isSuccess"];

      if (isSuccess == false) {
        ToastEasy.Error(jsonData["errorMessage"]);
      }

      return jsonData;
    } else {
      ToastEasy.Error("Ошибка запроса");

      return null;
    }
  } on EasyApiException catch (e) {
    ToastEasy.Error(e.message.toString());
  } catch (e) {
    ToastEasy.Error(e.toString());
  }
}

class EasyApiException implements Exception {
  EasyApiException(this.code, this.message);

  EasyApiException.withInner(
    this.code,
    this.message,
    this.innerException,
    this.stackTrace,
  );

  int code = 0;
  String? message;
  Exception? innerException;
  StackTrace? stackTrace;

  @override
  String toString() {
    if (message == null) {
      return 'ApiException';
    }
    if (innerException == null) {
      return 'ApiException $code: $message';
    }
    return 'ApiException $code: $message (Inner exception: $innerException)\n\n$stackTrace';
  }
}
