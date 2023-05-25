
import 'package:e_commerce/presentation/auth/login/view_model/cubit/login_cubit.dart';
import 'package:e_commerce/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/Profile/view_model/profile_cubit/profile_cubit.dart';
import '../presentation/auth/register/view_model/cubit/register_cubit.dart';
import '../presentation/layout/view_model/cubit/cubit.dart';
import '../presentation/resources/routs_manager.dart';

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesModel()
            ..getFavoritesModel()
            ..getUserData()

          ,
        ),
        BlocProvider(
          create: (BuildContext context) => ProfileCubit()
            ..getUserData()


        ),
        BlocProvider(
            create: (BuildContext context) => LoginCubit()

        ),
        BlocProvider(create: (BuildContext context) =>RegisterCubit()),

      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}