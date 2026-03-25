import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/AppStyle.dart';

class InputText extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final String? placeholder;
  final bool obscureText;
  final bool? isDisabled;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onEndFocus;
  final ValueChanged<String>? onSubmitted;
  final Widget? suffix;
  final Color? color;

  final bool isTextarea;

  final bool isAutoFocusOnStart;

  final bool isHideDecoration;

  const InputText({
    Key? key,
    this.label,
    this.controller,
    this.placeholder,
    this.isDisabled,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onEndFocus,
    this.onSubmitted,
    this.color,
    this.suffix,
    this.isTextarea = false,
    this.isAutoFocusOnStart = false,
    this.isHideDecoration = false,
  }) : super(key: key);


  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;

  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();


    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);

    if (widget.isAutoFocusOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();


        if (widget.controller != null)
          widget!.controller!.selection = TextSelection.fromPosition(
            TextPosition(offset: widget!.controller!.text.length),
          );
          //widget!.controller!.selection = TextSelection.collapsed(             offset: widget!.controller!.text.length,          );
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });

    // Дополнительные действия при изменении фокуса
    if (_focusNode.hasFocus) {
      //  print('TextField получил фокус');
    } else {
      if (widget.onEndFocus != null) {
        widget.onEndFocus!();
      }
      //print('TextField потерял фокус');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        if (widget.label != null && widget.label != "") ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Main",
              color: _hasFocus ? (widget.color ?? widget.color) : (widget.color
                  ?.withAlpha(230) ?? AppStyle().black.withAlpha(230)),
            ),
          ),
            SizedBox(height: AppStyle().paddingCard),
        ],

        AnimatedContainer(
          duration: Duration(milliseconds: 120),
          curve: Curves.easeInCubic,
          //margin: EdgeInsetsGeometry.only(bottom: _hasFocus ? 0 : 0),
          padding: (!widget.isHideDecoration) ? EdgeInsetsGeometry.only(
              bottom: 10) : null,
          decoration: (!widget.isHideDecoration) ? BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _hasFocus ? (widget.color ?? AppStyle().black) : (widget
                    .color?.withAlpha(60) ?? AppStyle().black.withAlpha(60)),
                width: _hasFocus ? 0.8 : 1,
              ),
            ),
          ) : null,

          child: CupertinoTextField(
            maxLines: widget.isTextarea ? 7 : 1,
            controller: widget.controller,
            placeholder: widget.placeholder,
            obscureText: widget.obscureText,
            suffix: widget.suffix,
            keyboardType: widget.keyboardType,
            cursorColor: (widget.color ?? AppStyle().black),
            focusNode: _focusNode,
            padding: (!widget.isHideDecoration) ? EdgeInsets.only(
              bottom: AppStyle().paddingCard / 2,
              top: AppStyle().paddingCard / 3,
            ) :  EdgeInsets.only(),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            style: ((widget.isDisabled ?? false) == false) ? TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: (widget.color ?? AppStyle().black),
                fontFamily: "Main")
                : TextStyle(fontSize: 16,
                fontWeight: FontWeight.w400,
                color: (widget.color ?? AppStyle().black).withAlpha(160),
                fontFamily: "Main"),
            placeholderStyle: TextStyle(fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ((widget.color ?? AppStyle().black)).withAlpha(142)),
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            enabled: (widget.isDisabled ?? false) == false,


          ),
        ),


      ],
    );
  }
}
