
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {

  //named constructor
  MyApp._internal();

  int appState =0;

  static final MyApp _instance =MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance;  //factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        /*BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesModel()
            ..getFavoritesModel()
            ..getUserData()

        ),*/
      ],
      child: MaterialApp(
              debugShowCheckedModeBanner: false,
            ),


    );
  }
}


