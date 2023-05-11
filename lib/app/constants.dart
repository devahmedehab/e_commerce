import 'package:e_commerce/presentation/auth/login/view/login_view.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

import '../data/network/cache_helper.dart';
import '../presentation/resources/component.dart';
import '../presentation/resources/routs_manager.dart';

/*class Constants{
  static const String baseUrl="https://ahmedehab122.mocklab.io/";
  static const String empty = "";
  //static const String token = "SEND TOKEN HERE";

  static const int zero = 0;
  static const int apiTimeOut = 60*1000; // 1 min time out



}*/
  String token = '';
var id = '';
void printFullText(String text) {
  final pattern = RegExp(AppStrings.regExp);
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
            (route) {
          return false;
        },
      );
    }
  });
}