

import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/font_manager.dart';
import 'package:e_commerce/presentation/resources/styles_manager.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(

    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,


    //ripple effect color

    //cardView theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
    ),

    //button theme
    buttonTheme: ButtonThemeData(


      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s20)),
      disabledColor: ColorManager.lightGrey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,

    ),
    textButtonTheme:   TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(ColorManager.primary)
      )
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s17,
        ),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
      ),
    ),

    //text theme
    textTheme: TextTheme(
      displayLarge: getLightStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s14,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.grey1,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.grey,
      ),
    ),

    //input Decoration Theme(text form field)
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: ColorManager.lightGrey,
      
      //contentPadding
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      //hintStyle
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      //label style
      labelStyle:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle:  getRegularStyle(color: ColorManager.error, ),

      //enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.lightGrey,width: AppSize.s1_5),
            borderRadius: const BorderRadius.all( Radius.circular(AppSize.s20))

      ),

      //focused border style
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all( Radius.circular(AppSize.s20),)
      ),


      //error border style
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all( Radius.circular(AppSize.s20),)
      ),

      //focused Error border style
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary,width: AppSize.s1_5),
          borderRadius: const BorderRadius.all( Radius.circular(AppSize.s20),)
      ),
    ),
  );
}
