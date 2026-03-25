import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:wins_core_flutter/formly/BuisnesLayer/ResponseContractOfFormlyFieldResponse.dart';
import 'package:wins_core_flutter/formly/FormFormly.dart';
import 'package:wins_core_flutter/formly/FormlyApiService.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';


class FormHandleMrp extends StatefulWidget {
  final FormlyApiService formlyService;
  final bool isDefaultButton;
  final Widget? buttonWidget;
  final Color? color;
  final double? padding;

  const FormHandleMrp({
    super.key,
    required this.formlyService,
    this.isDefaultButton = true,
    this.buttonWidget,
    this.color,
    this.padding,
  });

  @override
  _FormHandleMrpState createState() => _FormHandleMrpState();
}

class _FormHandleMrpState extends State<FormHandleMrp> {
  late bool isLoading = false;
  late bool isValid = false;
  late ResponseContractOfFormlyFieldResponse? responseFormData = null;

  late Map<String, dynamic> _formValues = {};

  @override
  void initState() {
    super.initState();
    GetData();
  }

  Future<void> SendData() async {


    print("senddata 0");

    if (!isValid) return;
    if (isLoading) return;

    print("senddata");
    setState(() {
      isLoading = true;
    });
    var xz = await widget.formlyService.sendTagUpdateValue(_formValues);

    setState(() {
      isLoading = false;
    });

    if (!xz.isSuccess) {
      print("no sended");

      return;
    }

    print("next");
  }

  Future<void> GetData() async {
    setState(() {
      isLoading = true;
    });

    var respnse = await widget.formlyService.getFormConfigurationFromServer();
    setState(() {
      responseFormData = respnse;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.formlyService.isLoaded || responseFormData == null)
      return Align(child: CircularProgressIndicator(color: widget.color ?? AppStyle().black));

    return Container(
      //height: 400,
      padding: EdgeInsetsGeometry.all(widget.padding ?? AppStyle().paddingCard),
      child: Column(
        children: [
          Opacity(
            opacity: isLoading ? 0.7 : 1,
            child: FormFormly(
              isShowButtonSave: widget.isDefaultButton && !isLoading,
              color: widget.color,
              formData: responseFormData!.value!,
              onValidChange: (x) {
                setState(() {
                  isValid = x;
                });
              },
              onChangeFull: (x) {
                _formValues = x;
              },
              onSubmit: (v) {
                SendData();
              },
            ),
          ),


          if (widget.buttonWidget != null && !isLoading)
            GestureDetector(
              //onTap: SendData,
              onTapDown: (x){
              SendData();
            }, child: widget.buttonWidget!, ),

          if (isLoading) CircularProgressIndicator(color: widget.color ?? AppStyle().black),
        ],
      ),
    );
  }
}
