
import 'package:e_commerce/presentation/layout/shop_layout.dart';
import 'package:e_commerce/presentation/onBoarding/view/onboarding_view.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';

import '../auth/login/view/login_view.dart';
import '../auth/register/view/register_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String shopLayout = "/main";
  static const String storeDetailsRouts = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.shopLayout:
        return MaterialPageRoute(builder: (_) => const ShopLayoutView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      /*
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());

      case Routes.storeDetailsRouts:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());*/

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
