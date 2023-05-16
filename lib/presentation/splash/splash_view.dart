import 'dart:async';
import 'package:e_commerce/presentation/resources/assets_manager.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/component/component.dart';
import 'package:e_commerce/presentation/resources/constants_manager.dart';
import 'package:flutter/material.dart';
import '../resources/routs_manager.dart';



class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay(){
    _timer=Timer(
        const Duration(seconds: AppConstant.splashDelay),
        _goNext
    );
  }
  _goNext(){
    navigateAndFinish(context, Routes.onBoardingRoute);
  }
  @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:  Center(
          child: Image(
            image: AssetImage(ImageAssets.splashLogo),
          )),
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
