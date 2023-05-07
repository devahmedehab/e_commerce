import 'package:bloc/bloc.dart';
import 'package:e_commerce/app/app.dart';
import 'package:e_commerce/bloc_observer.dart';
import 'package:e_commerce/data/network/cache_helper.dart';
import 'package:e_commerce/data/network/dio_helper.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
 // token = CacheHelper.getData(key: 'token');

  runApp(MyApp());

}