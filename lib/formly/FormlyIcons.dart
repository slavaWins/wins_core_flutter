import 'package:flutter/material.dart';


IconData FormlyIconMapping(String tag) {


  if(tag=="security") return Icons.privacy_tip_outlined;
  if(tag=="privacy") return Icons.lock_clock_outlined;
  if(tag=="work")return  Icons.tab_rounded;
  //if(tag=="social")return ClubIcons.soc;
  if(tag=="profile")return Icons.info_outline;
  if(tag=="name")return Icons.account_circle_outlined;
  //if(tag=="about")return ClubIcons.about;

  print("NOT MAPED ICON FormlyIconMapping: " + tag);

  return Icons.circle_outlined;
}