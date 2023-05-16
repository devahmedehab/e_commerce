import 'package:e_commerce/app/constants.dart';
import 'package:e_commerce/bloc_observer.dart';
import 'package:e_commerce/data/network/cache_helper.dart';
import 'package:e_commerce/presentation/layout/view/layout.dart';
import 'package:e_commerce/presentation/resources/routs_manager.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/network/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  CacheHelper.init();
  bool? onBoarding;
    onBoarding =await CacheHelper.getData(key: 'onBoarding');
   token =await CacheHelper.getData(key: 'token');
  String widget;


  if (onBoarding != null) {
    if (token != null)
      widget = Routes.layoutRoute ;
    else
      widget = Routes.loginRoute;

  } else {
    widget = Routes.onBoardingRoute;
  }


  runApp(MyApp());
}