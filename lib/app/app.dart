
import 'package:e_commerce/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';

import '../presentation/resources/routs_manager.dart';

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
    return MaterialApp(
      //home: ,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}


