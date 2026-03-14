import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../WinsCoreConfig.dart';
import '../style/AppStyle.dart';
import 'BuisnesLayer/ResponseContractOfMrpIndexPageData.dart';
import 'FormPageRenderFormly.dart';
import 'FormlyIcons.dart';

class TabRenderFormly extends StatefulWidget {
  final String controllerEndpointName;
  final int projectId;
  final String? title;
  final bool? isShowTitle;
  final Function(dynamic)? onResponseUpdateJson;

  const TabRenderFormly({
    Key? key,
    required this.controllerEndpointName,
    required this.projectId,
      this.title,
      this.isShowTitle,
    this.onResponseUpdateJson,
  }) : super(key: key);

  @override
  _TabRenderFormlyState createState() => _TabRenderFormlyState();
}

class _TabRenderFormlyState extends State<TabRenderFormly> {


  late final String baseUrl = WinsCoreConfig.domainApi;
  late bool isLoaded = false;
  late final ResponseContractOfMrpIndexPageData? responseTabResult;

  Future<void> getTabs() async {
    try {
      var request = http.Request(
        'GET',
        Uri.parse(
          baseUrl +
              widget.controllerEndpointName +
              "/Tabs/" +
              (widget.projectId.toString()),
        ),
      );

      final token =WinsCoreConfig.jwt;
      request.headers['Authorization'] = 'Bearer $token';

      var httpResponse = await request.send();
      final responseBody = await httpResponse.stream
          .bytesToString(); // Получаем тело ответа

      if (httpResponse.statusCode == 200) {
        final jsonData = jsonDecode(responseBody);

        responseTabResult = ResponseContractOfMrpIndexPageData.fromJson(
          jsonData,
        );
        setState(() {
          isLoaded = true;
        });
      } else {
        print("Request failed with status: ${httpResponse.statusCode}");
        // Можно выбросить исключение или обработать ошибку
        throw Exception('Failed to load tabs');
      }
    } catch (e) {
      print("Error in getTabs: $e");
      // Обработка ошибок
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();

    getTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(

      children: [

        if(widget.title!=null)
          Text(  widget.title!),

        if (!isLoaded)
          LoadingAnimationWidget.staggeredDotsWave(
            color: AppStyle().accent,
            size: 200,
          ),

        if (isLoaded)
          ...responseTabResult!.value!.tabs.map(
            (field) => CupertinoListTile(
              padding: EdgeInsets.all(AppStyle().paddingCard),
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  CupertinoPageRoute(
                    builder: (context) => FormPageRenderFormly(
                      title: widget.title ?? "",
                      controllerEndpointName: widget.controllerEndpointName,
                      projectId: widget.projectId,
                      tag: field.tag!,
                      onResponseUpdateJson: widget.onResponseUpdateJson,
                    ),
                  //  fullscreenDialog: true,
                  ),
                );
              },

              title: Text(field.name! , style: AppStyle().body1()),
              //leading: Icon(CupertinoIcons.person),

              leading: Icon( FormlyIconMapping(field.tag!), color: AppStyle().black, size: 24),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*
                  Text(
                    "Перейти",
                    style: AppStyle().body2(color: AppStyle().black54),
                  ),

                    const SizedBox(width: 8),*/
                    Icon(CupertinoIcons.forward, color: AppStyle().black, size: 20),

                ],
              ),
            ),
          ),
      ],
      )
    );
  }
}
