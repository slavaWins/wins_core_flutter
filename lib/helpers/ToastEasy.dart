import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../style/AppStyle.dart';

class ToastEasy {
  ToastEasy.Info(String text, IconData icon) {
    toastification.show(
      icon: Icon(icon),
      title: Text(text, style: AppStyle().body1(color: AppStyle().black)),
      type: ToastificationType.custom(
        "n",
        AppStyle().white.withAlpha(240),
        icon,
      ),
      animationDuration: Duration(milliseconds: 200),
      autoCloseDuration: Duration(seconds: 3),
      style: ToastificationStyle.fillColored,
      alignment: AlignmentGeometry.bottomRight,

    );
  }

  ToastEasy.Error(String text) {
    toastification.show(
      icon: Icon(Icons.error_outline),
      title: Text(text, style: AppStyle().body1(color: AppStyle().black)),
      type: ToastificationType.error,
      animationDuration: Duration(milliseconds: 200),
      autoCloseDuration: Duration(seconds: 3),
      style: ToastificationStyle.fillColored,
      alignment: AlignmentGeometry.bottomRight,
    );
  }
}
