
import 'package:e_commerce/presentation/layout/view/layout.dart';
import 'package:e_commerce/presentation/onBoarding/view/onboarding_view.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/search/view/search_view.dart';
import 'package:e_commerce/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';

import '../Profile/profile_view.dart';
import '../auth/login/view/login_view.dart';
import '../auth/register/view/register_view.dart';
import '../settings_screen/settings_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String settingsRoute = "/forgetPassword";
  static const String layoutRoute = "/main";
  static const String storeDetailsRouts = "/storeDetails";
  static const String searchRouts = "/search";
  static const String profileRouts = "/profile";
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
      case Routes.layoutRoute:
        return MaterialPageRoute(builder: (_) => const LayoutView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.searchRouts:
        return MaterialPageRoute(builder: (_) =>  SearchView());
      case Routes.profileRouts:
        return MaterialPageRoute(builder: (_) =>  ProfileView());
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());

      /*
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());

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
