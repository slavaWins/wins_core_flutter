import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

Future<bool?> ModalAlert(
    BuildContext context, {
      String title = 'Вы действительно хотите выйти?',
      String content = 'Выход с приложения',
      String approve = 'Выход',
      String cancel = 'Отмена',
      Color? colorApprove = null,
      Color? colorExit =null,
    }) async {
  return await showDialog<bool>(
    context: context,

    builder: (BuildContext context) => AlertDialog(
      title: Text(title, style:  AppStyle().body2(),),
      content: Text(content, style:  AppStyle().body4(),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: TextButton.styleFrom(
            foregroundColor: colorApprove,
          ),
          child: Text(approve, style:  AppStyle().body2(),),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: TextButton.styleFrom(
            foregroundColor: colorExit,
          ),
          child: Text(cancel, style:  AppStyle().body2(),),
        ),
      ],
    ),
  );
}