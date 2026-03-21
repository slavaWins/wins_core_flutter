import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppTheme { light, dark }


class AppStyle {

  AppStyle._();
  static final AppStyle _instance = AppStyle._();
  factory AppStyle() => _instance;



  static AppTheme theme = AppTheme.light;

   Color  base_white = Colors.white;
  Color  base_black = Colors.black;
  Color  primary =  Color.fromARGB(255, 115, 185, 245) ;

  //Color  base_primary_gray =  Color.fromARGB(255, 43, 82, 119) ;

  Color  base_background_black = Color.fromARGB(255, 23, 33,43);
  Color  base_background_light = Color.fromARGB(255, 212, 212,212);


  double  paddingScreen = 10;
  double  paddingCard = 14; 
  double  input_label_margin_bottom = 11;

  Color base_messagebox_background_black = Color.fromARGB(255, 14, 22,33);

  Color get backgroundMessageBox => theme == AppTheme.light
      ? base_white
      : base_messagebox_background_black;




   Color get background => theme == AppTheme.light
      ? base_background_light
      : base_background_black;


   Color get white => theme == AppTheme.light
      ? base_white
      : base_black;

   Color get black => theme == AppTheme.light
      ? base_black
      : base_white;


   Color get card => theme == AppTheme.light
      ? base_white.withAlpha(200)
      : base_black.withAlpha(100);



   Color  accent = Color.fromARGB(255, 231, 231,0);
   Color  grayed = Color.fromARGB(253, 141, 141, 141);


   Color get black54 => black.withAlpha(160);
   Color get  white54 => white.withAlpha(160);
   Color get  border => black.withAlpha(110);


  void ChangeTheme() {

    if(theme==AppTheme.dark){
      theme=AppTheme.light;
    }else{
      theme=AppTheme.dark;
    }


    ApplyStyleSystem();

    ThemeNotification().CallUpdate();
  }
    Brightness get themeNameFlutter => theme == AppTheme.dark ? Brightness.dark : Brightness.light;


  Future<void> ApplyStyleSystem() async {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    SystemChrome.setSystemUIOverlayStyle(  SystemUiOverlayStyle(
      statusBarColor: background,
      systemNavigationBarColor: background,

      statusBarIconBrightness: themeNameFlutter, // для светлого фона dark
      systemNavigationBarIconBrightness: themeNameFlutter, //dark
      statusBarBrightness: themeNameFlutter, // Для светлого текста
    ));
  }


  double base_font_scale_h = 1;
  double base_font_szie_h1 = 36;
  FontWeight font_WeightNormal =  FontWeight.w400;


  TextStyle h1({Color? color}) {
    return TextStyle(
      fontSize: base_font_szie_h1 * base_font_scale_h,
      fontWeight: FontWeight.w400,
      color: color ?? black,
      fontFamily: "Main",
      letterSpacing: 0.0,
      height: 1,
    );
  }

  TextStyle h2({Color? color}) {
    return TextStyle(
      fontSize: 32 * base_font_scale_h,
      fontWeight: FontWeight.w400,
      color: color ?? black,
      fontFamily: "Main",
      letterSpacing: 0.0,
    );
  }

  TextStyle h3({Color? color}) {
    return TextStyle(
      fontSize: 28 * base_font_scale_h,
      fontWeight: FontWeight.w400,
      color: color ?? black,
      fontFamily: "Main",
      letterSpacing: 0.0,
      height: 1,
    );
  }

  TextStyle h4({Color? color}) {
    return TextStyle(
      fontSize: 24 * base_font_scale_h,
      fontWeight: FontWeight.w500,
      color: color ?? black,
      fontFamily: "Main",
      letterSpacing: 0.0,
    );
  }

  // Основной текст
  TextStyle body0({Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: color ?? black,
      fontFamily: "Main",
      letterSpacing: 0.0,
    );
  }

  TextStyle body1({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: font_WeightNormal,
      color: color ?? black,
      fontFamily: "Main",
      height: 1.2,
      letterSpacing: 0.0,
    );
  }

  TextStyle body2({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: font_WeightNormal,
      color: color ?? black,
      fontFamily: "Main",
      letterSpacing: 0.0,
    );
  }

  TextStyle body3({Color? color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: font_WeightNormal,
      color: color ?? black,
      fontFamily: "Main",
      letterSpacing: 0.0,
    );
  }

  TextStyle body4({Color? color}) {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w300,
      color: color ?? black,
      fontFamily: "Main",
      height: 1.15,
      letterSpacing: 0.0,
    );
  }

  // Специальные стили
  TextStyle inputLabel({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: font_WeightNormal,
      color: color ?? black,
      fontFamily: "Main",
      letterSpacing: 0.0,
    );
  }

}



class ThemeNotification extends ChangeNotifier {

  ValueChanged<dynamic>? onChange = null;

  static final ThemeNotification _instance =  ThemeNotification._internal();

  factory ThemeNotification() => _instance;

  ThemeNotification._internal();


  void CallUpdate() {
    notifyListeners();
    if(onChange!=null){    onChange!(1); }
  }
}