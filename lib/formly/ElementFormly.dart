
import 'package:flutter/material.dart';

import '../components/InputText.dart';
import '../style/AppStyle.dart';
import 'BuisnesLayer/FormlyField.dart';


typedef DualValueChanged<T1, T2> = void Function(T1 first, T2 second);

class ElementFormly extends StatefulWidget {
  final FormlyField data;
  final dynamic val;
  final ValueChanged<dynamic>? onChange;
  final ValueChanged<bool>? onSubmit;
  final ValueChanged<bool>? onValidChange;
  final Color? color;
  final bool isShowValidationErrorOnStart;

  const ElementFormly({
    Key? key,
    required this.data,
    this.val,
    this.onChange,
    this.onSubmit,
    this.onValidChange,
    this.isShowValidationErrorOnStart = false,
    this.color,
  }) : super(key: key);

  @override
  State<ElementFormly> createState() => _ElementFormlyState();
}

class _ElementFormlyState extends State<ElementFormly> {
  late bool valueBool = false;
  late String? isInvalid = null;

  bool isShowValidationErrorCan = false;
  late dynamic valResult;

  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    valResult = widget.val ?? "";

    if (widget.data.type == "select") {

      var _selectedNowHave = widget.data.props!.options          .where(            (opt) => opt.value.toString() == valResult.toString()).firstOrNull;
      if(_selectedNowHave==null){
        print("select value not init start. Autofix");
        _selectedNowHave =  widget.data.props!.options.firstOrNull;

        if(_selectedNowHave!=null) {
          valResult = _selectedNowHave.value.toString();
          print(valResult);
          widget.onChange?.call(valResult);
        }else{
          print("_selectedNowHave в опшинах нет вариантов!!!");
        }
      }

    }




    _controller = TextEditingController(text: valResult.toString());

    ValidateValue(valResult);

    if (widget.data.type == "checkbox") {
      valueBool = widget.val == true;
    }

    if (widget.data.type == "date") {
      widget.data.type = "string";
    }


    ValidCheckOnStart();
  }


  void ValidCheckOnStart() async {
    await Future.delayed(Duration(milliseconds: 200));
    ValidateValue(valResult);
    if (widget.onValidChange != null) {
      widget.onValidChange!(isInvalid == null);
    }
  }


  void ValueSetTo(dynamic val) {
    valResult = val;
    if (widget.onChange != null) {
      widget.onChange!(val);
    }

    ValidateValue(val);

    if (widget.onValidChange != null) {
      widget.onValidChange!(isInvalid == null);
    }
  }

  void ValidateValue(dynamic val) {
    var props = widget.data.props!;

    if (props.isCanBeNull == true && val.toString().length==0) {
      isInvalid = null;
      return;
    }

    if (props.minLength != null) {
      if (val.toString().length < props.minLength!) {
        isInvalid =
            "Длина поля должна быть более " +
            widget.data.props!.minLength.toString() +
            " символов";
        return;
      }
    }

    if (props.maxLength != null) {
      if (val.toString().length > props.maxLength!) {
        isInvalid =
            "Длина поля должна быть менее " +
            widget.data.props!.minLength.toString() +
            " символов";
        return;
      }
    }

    if (props.startWith != null) {
      if (!val.toString().startsWith(widget.data.props!.startWith!)) {
        isInvalid = "Должно начинаться на " + props.startWith!.toString();
        return;
      }
    }

    if (props.endWith != null) {
      if (!val.toString().endsWith(widget.data.props!.endWith!)) {
        isInvalid = "Должно заканчиваться на " + props.endWith!.toString();
        return;
      }
    }

    isInvalid = null;
  }

  @override
  Widget build(BuildContext context) {

    if(widget.data.hide_ == true){
      //return Text("XXX HIDE");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 0,
      children: [
        //Text(widget.data.key.toString()),
        SizedBox(height: 16),

        if (widget.data.key != "id") ...[
          if (widget.data.props?.label != null &&
              widget.data.type != "string" &&
              widget.data.type != "textarea" &&
              widget.data.type != "select" &&
              widget.data.type != "checkbox") ...[
            Text(
              widget.data.props?.label ?? "",
              style: AppStyle().body2(),
            ),
            SizedBox(height: 11),
          ],

          if (widget.data.type == "string" || widget.data.type == "textarea")
            InputText(
              isTextarea: widget.data.type == "textarea",
              color: (isInvalid != null && isShowValidationErrorCan)
                  ? Colors.red
                  : widget.color,
              label: widget.data.props?.label,
              placeholder: widget.data.props?.placeholder ?? "Text",
              controller: _controller,
              onSubmitted: (b) {
                if (widget.onSubmit != null) widget.onSubmit!(true);
              },
              onEditingComplete: () {
                print("comp");
                setState(() {
                  ValidateValue(valResult);
                  isShowValidationErrorCan = true;
                });
              },
              onEndFocus: () {
                print("onEndFocus");

                setState(() {
                  ValidateValue(valResult);
                  isShowValidationErrorCan = true;
                });
              },
              onChanged: (val) {
                ValueSetTo(val);
              },
            ),

          if (widget.data.type == "select")
            GestureDetector(
              onTap: _showSelectDialog,

              child: AbsorbPointer(
                child: InputText(
                  color: (isInvalid != null && isShowValidationErrorCan)
                      ? Colors.red
                      : widget.color,
                  suffix: Icon(Icons.arrow_drop_down_outlined),
                  label: widget.data.props?.label,
                  placeholder: widget.data.props?.placeholder ?? "Выберите",
                  controller: TextEditingController(
                    text: widget.data.props?.options
                        .firstWhere(
                          (opt) => opt.value == valResult,
                          orElse: () => widget.data.props!.options.first,
                        )
                        .label,
                  ),
                ),
              ),
            ),

          if (widget.data.type == "checkbox") ...[
            ListTile(
              onTap: () {
                final newValue = !valueBool;
                setState(() {
                  valueBool = newValue;
                });
                widget.onChange?.call(newValue);
              },
              title: Text(
                widget.data.props?.label ?? "",
                style: AppStyle().body1(color: widget.color),
              ),
              trailing: Transform.scale(
                scale: 0.7,
                // уменьшаем размер (0.7 = 70% от оригинального размера)
                child: Switch(
                 // thumbColor:  AppStyle().background,

                  inactiveTrackColor: AppStyle().black.withAlpha(90),

                  activeTrackColor: AppStyle().accent,
                  inactiveThumbColor: Colors.white,

                  value: valueBool,
                  onChanged: (v) {
                    valResult = v;

                    setState(() {
                      valueBool = v;
                    });

                    if (widget.onChange != null) {
                      widget.onChange!(v);
                    }
                  },

                  //placeholder: data.props?.placeholder ?? "Text",
                ),
              ),
            ),
          ],

          if (isInvalid != null && isShowValidationErrorCan)
            Text(
              isInvalid ?? "Ошибка",
              style: AppStyle().body3(color: Colors.red),
            ),

          if (widget.data.props?.description != null) ...[
            SizedBox(height: 7),
            Text(
              widget.data.props?.description ?? "",
              style: AppStyle().body3(color: widget.color),
            ),
          ],
          SizedBox(height: 22),
        ],
      ],
    );
  }

  void _showSelectDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  widget.data.props?.label ?? 'Выберите',
                  style: AppStyle().body0(),
                ),
              ),
              Divider(height: 1),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ...widget.data.props?.options.map(
                          (option) => ListTile(
                        title: Text(
                          option.label,
                          style: AppStyle().body1(),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          setState(() {
                            valResult = option.value ?? "";
                          });
                          widget.onChange?.call(option.value ?? "");
                          Navigator.pop(context);
                        },
                      ),
                    ).toList() ?? [],
                  ],
                ),
              ),
              Divider(height: 1),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text(
                  'Отмена',
                  style: AppStyle().body0(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
