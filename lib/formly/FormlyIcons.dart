import 'package:flutter/material.dart';
import 'package:wins_core_flutter/WinsCoreConfig.dart';


IconData FormlyIconMapping(String tag) {

print(WinsCoreConfig.iconTagsMapper);
  if(WinsCoreConfig.iconTagsMapper.containsKey(tag)){
    return WinsCoreConfig.iconTagsMapper[tag]!;
  }

  if(tag=="security") return Icons.privacy_tip_outlined;
  if(tag=="privacy") return Icons.lock_clock_outlined;
  if(tag=="work")return  Icons.tab_rounded;
  if(tag=="profile")return Icons.info_outline;
  if(tag=="name")return Icons.account_circle_outlined;
  //if(tag=="about")return ClubIcons.about;
  //if(tag=="social")return ClubIcons.soc;

  print("NOT MAPED ICON tag FormlyIconMapping: " + tag);

  return Icons.circle_outlined;
}