// В вашем пакете
import 'package:flutter/cupertino.dart';

class FormlyNavigationConfig {

  static Color? FormMrpEdit_Color_Background;
  static Color? FormMrpEdit_Color_Content;

  static Widget Function(
      BuildContext context,
      String title,
      bool isValid,
      VoidCallback onSubmit,
      VoidCallback onClose,
      )? navigationBuilder;

}
