import 'package:e_commerce/bloc_observer.dart';
import 'package:e_commerce/data/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/network/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
 // bool onBoarding =await CacheHelper.getData(key: 'onBoarding');
 // token =await CacheHelper.getData(key: 'token');



  runApp(MyApp());
}
