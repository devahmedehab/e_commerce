import 'package:bloc/bloc.dart';
import 'package:e_commerce/app/app.dart';
import 'package:e_commerce/bloc_observer.dart';
import 'package:e_commerce/data/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'app/constants.dart';
import 'data/network/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
 // bool onBoarding =await CacheHelper?.getData(key: 'onBoarding');
   token =await CacheHelper.getData(key: 'token');
 // Widget widget;

 /* if (onBoarding !=null ) {
    if (token != null )
      widget = ShopLayout();
    else
      widget = ShopLoginView();
  } else {
    widget = OnBoardingView();
  }*/

  runApp(MyApp());

}