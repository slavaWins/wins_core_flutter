
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toastification/toastification.dart';

import '../WinsCoreConfig.dart';
import '../style/AppStyle.dart';
import 'BuisnesLayer/ResponseContractOfFormlyFieldResponse.dart';
import 'FormPageRenderFormly.dart';


class FormlyApiService  extends ChangeNotifier  {


  final String controllerEndpointName;
  final String tag;
  final int projectId;


  late final String baseUrl = WinsCoreConfig.domainApi;
  late bool isLoaded = false;
  late  ResponseContractOfFormlyFieldResponse? responseFormData;

  final Function(dynamic)? onResponseUpdateJson;

   FormlyApiService({
     required this.controllerEndpointName,
     required this.projectId,
     required this.tag,
      this.onResponseUpdateJson});

  Future<FormlyLocalResponse> makSubmit(dynamic values) async {

      return await sendTagUpdateValue(values);

  }

  Future<FormlyLocalResponse> sendTagUpdateValue(dynamic dataSend) async {
    try {
      var url =
          baseUrl +
              controllerEndpointName +
              "/" +
              tag +
              "/update";

      print(url);
      print(dataSend);
      var request = http.Request('POST', Uri.parse(url));

      request.body = jsonEncode(dataSend);
      print(request.body);

      final token = WinsCoreConfig.jwt;
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';

      var httpResponse = await request.send();
      final responseBody = await httpResponse.stream
          .bytesToString(); // Получаем тело ответа

      if (httpResponse.statusCode == 200) {
        var resp = jsonDecode(responseBody);

        dynamic isSuccess = resp["isSuccess"];
        print("RESPONSE isSuccess:");
        print(isSuccess);

        if (isSuccess == false) {

          toastification.show(
            icon: Icon(Icons.warning_amber),
            title: Text(resp["errorMessage"], style: AppStyle().body1(color: Colors.white)),
            type: ToastificationType.error,
            animationDuration: Duration(milliseconds: 200),
            autoCloseDuration: Duration(seconds: 3),
            style: ToastificationStyle.fillColored,
          );

          return FormlyLocalResponse.error(
            errorMessage: resp["errorMessage"],
            errorKey: resp["keyError"],
          );
        }

        if (onResponseUpdateJson != null) {
          dynamic value = resp["value"];
          onResponseUpdateJson!(value);
        }

        return FormlyLocalResponse.success();
      } else {
        print("Request failed with status: ${httpResponse.statusCode}");
        // Можно выбросить исключение или обработать ошибку
        throw Exception('Failed to load tabs');
      }
    } catch (e) {

      toastification.show(
        icon: Icon(Icons.warning_amber),
        title: Text("Ошибка сервера", style: AppStyle().body1(color: Colors.white)),
        type: ToastificationType.warning,
        animationDuration: Duration(milliseconds: 200),
        autoCloseDuration: Duration(seconds: 2),
        style: ToastificationStyle.fillColored,
      );

      print("Error in getTabs: $e");
      // Обработка ошибок
      rethrow;
    }
  }


  Future<ResponseContractOfFormlyFieldResponse> getFormConfigurationFromServer() async {


    print("getFormConfigurationFromServer");
    try {
      var url =
          baseUrl +
              controllerEndpointName +
              "/form/" +
              (projectId.toString()) +
              "/" +
              tag;

      var request = http.Request('GET', Uri.parse(url));

      final token = WinsCoreConfig.jwt;
      request.headers['Authorization'] = 'Bearer $token';

      var httpResponse = await request.send();
      final responseBody = await httpResponse.stream
          .bytesToString(); // Получаем тело ответа

      if (httpResponse.statusCode == 200) {
        final jsonData = jsonDecode(responseBody);
      //  print(jsonData);
        responseFormData = ResponseContractOfFormlyFieldResponse.fromJson(
          jsonData,
        );

   //     print(responseFormData);

        isLoaded = true;

        notifyListeners();
        return responseFormData!;

      } else {
        print("Request failed with status: ${httpResponse.statusCode}");
        // Можно выбросить исключение или обработать ошибку
        throw Exception('Failed to load tabs');
      }
    } catch (e) {
      print("Error in getTabs: $e");

      notifyListeners();
      // Обработка ошибок
      rethrow;
    }
  }
}