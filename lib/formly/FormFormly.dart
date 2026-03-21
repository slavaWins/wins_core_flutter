import 'package:flutter/cupertino.dart';

import 'package:wins_core_flutter/style/AppStyle.dart';
import 'BuisnesLayer/FormlyField.dart';
import 'BuisnesLayer/FormlyFieldResponse.dart';
import 'ElementFormly.dart';


class FormFormly extends StatefulWidget {
  final FormlyFieldResponse formData;
  final Function(dynamic)? onSubmit;
  final Function(Map<String, dynamic>)? onChangeFull;
  final bool? isShowButtonSave;
  final ValueChanged<bool>? onValidChange;
  final Color? color ;

  const FormFormly({
    Key? key,
    required this.formData,
    this.onSubmit,
    this.onChangeFull,
    this.onValidChange,
    this.isShowButtonSave,
    this.color,
  }) : super(key: key);

  @override
  State<FormFormly> createState() => FormFormlyState();
}

class FormFormlyState extends State<FormFormly> {
  // Хранилище значений формы
  late Map<String, dynamic> _formValues = {};
  late Map<String, bool> validationValues  = {};

  @override
  void initState() {
    super.initState();
    _formValues = (widget.formData.values as Map<String, dynamic>)?? {};


    if(widget.onChangeFull!=null){
      widget.onChangeFull!(_formValues);
    }

  }

  void ValidRowSet(String key, bool isValid) {

    validationValues[ key] = isValid;

    if(widget.onValidChange!=null){
      bool isAllValid = validationValues.values.every((value) => value == true);
      widget.onValidChange!(isAllValid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...widget.formData.formlyFields.map(
          (field) => ElementFormly(
           // key: const ValueKey('my_field'),
            color: widget.color  ,
            data: field,
            val: _getInitialValue(field),
            onValidChange: (v){
              ValidRowSet( field.key!, v);
            },
            onSubmit: (v){
              submitForm();
            },
            onChange: (v) {
              _formValues[ field.key!] = v;
              if(widget.onChangeFull!=null)widget.onChangeFull!(_formValues);
            },
          ),
        ),

        if (widget.isShowButtonSave ?? false)
          CupertinoButton(
            child: Text(widget.formData.btnName ?? "Ok", style:  AppStyle().body1(color: widget.color)),
            onPressed: () {
              submitForm();
            },
          ),

        SizedBox(height: 16),
      ],
    );
  }


  dynamic _getInitialValue(FormlyField field) {
    return _formValues[field.key] ?? "";
  }


  void submitForm() {
    widget.onSubmit?.call(collectFormData());
  }


  dynamic collectFormData() {
    print("XX _collectFormData");
    return _formValues;
  }
}
