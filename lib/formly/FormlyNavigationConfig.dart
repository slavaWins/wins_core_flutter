// В вашем пакете
import 'package:flutter/cupertino.dart';

class FormlyNavigationConfig {
  static Widget Function(
      BuildContext context,
      String title,
      bool isValid,
      VoidCallback onSubmit,
      VoidCallback onClose,
      )? navigationBuilder;

  static void configure({
    Widget Function(
        BuildContext context,
        String title,
        bool isValid,
        VoidCallback onSubmit,
        VoidCallback onClose,
        )? navigationBuilder,
  }) {
    FormlyNavigationConfig.navigationBuilder = navigationBuilder;
  }
}
