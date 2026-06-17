import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final Function(LogicalKeyboardKey key, bool isShiftPressed)? onKey;
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
    this.onKey ,
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

    _focusNode = FocusNode(
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyDownEvent) {

          if(widget.onKey!=null){
            widget.onKey!(event.logicalKey, HardwareKeyboard.instance.isShiftPressed);
          }


/*
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            return KeyEventResult.handled; // Prevents further propagation
          }
*/
        }
        return KeyEventResult.ignored; // Lets other widgets handle the key
      },
    );

    _focusNode.addListener(_onFocusChange);

    if (widget.isAutoFocusOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();


        if (widget.controller != null && widget.controller!.text.isNotEmpty) {
          //widget.controller!.selection = TextSelection.collapsed(            offset: widget.controller!.text.length,          );
        }

        /*
        if (widget.controller != null)
          widget!.controller!.selection = TextSelection.fromPosition(
            TextPosition(offset: widget!.controller!.text.length),
          );
        */

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
              color: _hasFocus
                  ? (widget.color ?? widget.color)
                  : (widget.color?.withAlpha(230) ??
                        AppStyle().black.withAlpha(230)),
            ),
          ),
          SizedBox(height: AppStyle().paddingCard),
        ],

        AnimatedContainer(
          duration: Duration(milliseconds: 120),
          curve: Curves.easeInCubic,
          margin: EdgeInsetsGeometry.zero ,
          //margin: EdgeInsetsGeometry.only(bottom: _hasFocus ? 0 : 0),
          padding: (!widget.isHideDecoration)
              ? EdgeInsetsGeometry.only(bottom: 1)
              : EdgeInsets.zero  ,
          decoration: (!widget.isHideDecoration)
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _hasFocus
                          ? (widget.color ?? AppStyle().black)
                          : (widget.color?.withAlpha(60) ??
                                AppStyle().black.withAlpha(60)),
                      width: _hasFocus ? 0.8 : 1,
                    ),
                  ),
                )
              : null,

          child: TextField(
            maxLines: widget.isTextarea ? 7 : 1,
            controller: widget.controller,

            obscureText: widget.obscureText,



            //   suffix: widget.suffix,
            keyboardType: widget.keyboardType,
            cursorColor: (widget.color ?? AppStyle().black),
            focusNode: _focusNode,
            decoration: InputDecoration(
              isDense: true,  // <- КЛЮЧЕВОЙ ПАРАМЕТР
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "Main",
                color: ((widget.color ?? AppStyle().black)).withAlpha(142),
              ),
              border: InputBorder.none,

              contentPadding: (!widget.isHideDecoration)
                  ? EdgeInsets.only(
                      bottom: AppStyle().paddingCard / 2,
                      top: AppStyle().paddingCard / 8,
                    )
                  : EdgeInsets.zero ,
              fillColor: Colors.transparent,
            ),

            style: ((widget.isDisabled ?? false) == false)
                ? TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: (widget.color ?? AppStyle().black),
                    fontFamily: "Main",
                  )
                : TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: (widget.color ?? AppStyle().black).withAlpha(160),
                    fontFamily: "Main",
                  ),
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
