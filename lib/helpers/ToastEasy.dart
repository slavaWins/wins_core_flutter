import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../style/AppStyle.dart';

class ToastEasy {

  static AlignmentGeometry alignmentGeometryDef = AlignmentGeometry.bottomRight;


  ToastEasy.Info(String text, IconData icon) {
    toastification.show(
      icon: Icon(icon, color: AppStyle().black),
      title: Text(text, style: AppStyle().body1(color: AppStyle().black)),
      type: ToastificationType.custom(
        "n",
        AppStyle().white.withAlpha(240),
        icon,
      ),
      animationDuration: Duration(milliseconds: 200),
      autoCloseDuration: Duration(seconds: 3),
      style: ToastificationStyle.fillColored,
      alignment: alignmentGeometryDef,

    );
  }

  ToastEasy.Error(String text) {
    toastification.show(
      icon: Icon(Icons.error_outline, color: AppStyle().black),
      title: Text(text, style: AppStyle().body1(color: AppStyle().black)),
      type: ToastificationType.error,
      animationDuration: Duration(milliseconds: 200),
      autoCloseDuration: Duration(seconds: 3),
      style: ToastificationStyle.fillColored,
      alignment: alignmentGeometryDef,
    );
  }
}
