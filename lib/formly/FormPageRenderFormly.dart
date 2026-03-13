import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../WinsCoreConfig.dart';
import '../style/AppStyle.dart';
import 'BuisnesLayer/ResponseContractOfFormlyFieldResponse.dart';
import 'FormFormly.dart';
import 'FormlyApiService.dart';

class FormlyLocalResponse {
  final bool isSuccess;
  final String? errorMessage;
  final String? errorKey;

  const FormlyLocalResponse({
    required this.isSuccess,
    this.errorMessage,
    this.errorKey,
  });

  // Фабричный метод для успешного ответа
  factory FormlyLocalResponse.success() {
    return FormlyLocalResponse(isSuccess: true);
  }

  // Фабричный метод для ответа с ошибкой
  factory FormlyLocalResponse.error({String? errorMessage, String? errorKey}) {
    return FormlyLocalResponse(
      isSuccess: false,
      errorMessage: errorMessage,
      errorKey: errorKey,
    );
  }
}

class FormPageRenderFormly extends StatefulWidget {
  final String controllerEndpointName;
  final int projectId;
  final String title;
  final String tag;
  final Function(dynamic)? onResponseUpdateJson;

  const FormPageRenderFormly({
    Key? key,
    required this.controllerEndpointName,
    required this.projectId,
    required this.title,
    required this.tag,
    this.onResponseUpdateJson,
  }) : super(key: key);

  @override
  _FormPageRenderFormlyState createState() => _FormPageRenderFormlyState();
}

class _FormPageRenderFormlyState extends State<FormPageRenderFormly> {

  final GlobalKey<FormFormlyState> _formKey = GlobalKey();

  late final String baseUrl = WinsCoreConfig.domainApi;
  late bool isLoaded = false;
  late final ResponseContractOfFormlyFieldResponse? responseFormData;


  late bool isValid = false;

  FormlyApiService? formlyService;

  @override
  void initState() {
    super.initState();


    formlyService = FormlyApiService(
      controllerEndpointName: widget.controllerEndpointName,
      projectId: widget.projectId,
      tag: widget.tag,
    );

    AfterInit();
  }


  void AfterInit() async {

    responseFormData = await formlyService!.getFormConfigurationFromServer();
    setState(() {

      isLoaded = formlyService!.isLoaded;
    });
  }

  Future<FormlyLocalResponse> makSubmit() async {
    final formState = _formKey.currentState;
    if (formState != null) {
      // Получаем значения
      final values = formState.collectFormData();
      return await formlyService!.sendTagUpdateValue(values);
    }
    return FormlyLocalResponse.error(errorMessage: "Нет данных отправки");
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor:  Color.fromARGB(255, 48, 48, 48),
      child: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),

            /*
            ClubNavigation(
              title: widget.title,
              colorText: Colors.white,
              isPopSupport: true,
              padding: 0,
              iconPop: ClubIcons.close,



              trilingCustom: CircleButtonClubColored(
                icon: ClubIcons.check,
                size: 55,
                color: isValid ? AppStyle().accent : Colors.grey,
                onPressed: () async {
                 // if(!isValid)return;

                  var r = await makSubmit();
                  if (r.isSuccess) {
                    Navigator.of(context).pop();
                  } else {
                   // showBaseInfoDialog(context, r.errorMessage ?? "na001");
                  }
                },
              ),
            ),
*/
            SizedBox(height: 60),

            if (!isLoaded)
              LoadingAnimationWidget.staggeredDotsWave(
                color: AppStyle().black,
                size: 200,
              ),

            if (isLoaded && responseFormData != null)
              FormFormly(
                color: Colors.white,
                formData: responseFormData!.value!,
                onSubmit: (x) {},

                onValidChange: (x) {

                  setState(() {
                    isValid = x;
                  });
                },
                key: _formKey,
              ),
          ],
        ),
      ),
    );
  }
}
