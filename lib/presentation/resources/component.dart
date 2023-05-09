import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'assets_manager.dart';

Widget defaultFormField(
        {Iterable<String>? autofill,
        List<TextInputFormatter>? format,
        TextEditingController? controller,
        TextInputType? type,
        Function? onSubmit,
        Function? onTap,
        Function? onChange,
        bool isPassword = false,
        Function? validate,
        String? labelText,
        String? hintText,
        String? errorText,
        IconData? prefix,
        IconData? suffix,
        Function? suffixPressed,
        bool isClickable = true,
        context}) =>
    TextFormField(
      autofillHints: autofill,
      enableInteractiveSelection: true,
      inputFormatters: format,
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onTap: () {
        onTap;
      },
      enabled: isClickable,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed;
                },
                icon: Icon(
                  suffix,
                  color: Colors.grey,
                ))
            : null,
        prefixIcon: Icon(
          prefix,
        ),
      ),
    );

IconData suffix = Icons.visibility_outlined;
bool isPassword = true;

void changePasswordVisibility() {
  isPassword = !isPassword;
  suffix =
      isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
}

Widget defaultTextButton({
  Color? color,
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function;
      },
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color? color,
  bool isUpperCase = true,
  double radius = 20.0,
  required Function function,
  required String text,
}) =>
    Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: ColorManager.primary,
      ),
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );

class defultTextFormField extends StatelessWidget {
  defultTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.validator,
    required this.inputType,
    this.hint,
    this.maxLines,
    this.focusColor,
    this.hintColor,
    this.icon,
    this.suffixIcon,
    this.prefixIcon,

    this.textDirection,
    required this.isObsecured,
  }) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final TextInputType inputType;
  String? hint;

  Color? focusColor;
  Color? hintColor;
  Widget? icon;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextDirection? textDirection;
  int? maxLines;
  bool isObsecured = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecured,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      validator: validator,
      controller: controller,
      keyboardType: inputType,

      //  maxLines: maxLines ??  AppSize.s1,
      textDirection: textDirection ?? TextDirection.rtl,
      textAlignVertical: TextAlignVertical.center,
       cursorHeight: AppSize.s28,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            height: AppSize.s2,
          ),
      decoration: InputDecoration(

        alignLabelWithHint: true,
        isCollapsed: true,
        filled: true,
        fillColor: focusColor,
        focusColor: focusColor,
        hintText: hint ?? '',
       /* hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: hintColor,
            ),*/

        label: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: ColorManager.grey1,
              ),
        ),
        contentPadding: const EdgeInsets.only(
          right: AppPadding.p20,
          left: AppPadding.p20,
          bottom: AppPadding.p20,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        focusedBorder: _outlineInputBorder(),
        enabledBorder: _outlineInputBorderStyle(),
        errorBorder: _outlineInputBorderErrorStyle(),

      ),

    );
  }
}

OutlineInputBorder _outlineInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorManager.primary,

      width: AppSize.s0_5,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(AppSize.s20),
    ),
  );
}

OutlineInputBorder _outlineInputBorderStyle() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorManager.grey,
      width: AppSize.s1,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(AppSize.s20),
    ),
  );
}

OutlineInputBorder _outlineInputBorderErrorStyle() {
  return  OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorManager.error,
      width: AppSize.s1,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(AppSize.s20),
    ),
  );
}

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushReplacementNamed(
      context,
      widget
    );

void navigateTo(context, widget) => Navigator.pushNamed(
  context,
  widget
);

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = ColorManager.success;
      break;
    case ToastStates.ERROR:
      color = ColorManager.error;
      break;
    case ToastStates.WARNING:
      color = ColorManager.amber;
      break;
  }

  return color;
}

class MainButton extends StatelessWidget {
  MainButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  final String title;
  final Function onPressed;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: AppSize.s55,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.p20),
          ),
          onPressed: () => onPressed(),
          color: color ?? ColorManager.primary,
          disabledColor: ColorManager.white,
          child: Text(title, style: TextStyle(color: ColorManager.white),),
        ));
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageAssets.onBoardingLogo1,
      height: mediaQueryHeight(context) / AppSize.s8,
      fit: BoxFit.cover,
    );
  }
}

class AuthTitleAndSubtitle extends StatelessWidget {
  const AuthTitleAndSubtitle(
      {Key? key, required this.authTitle, required this.authSubtitle})
      : super(key: key);

  final String authTitle;
  final String authSubtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: mediaQueryHeight(context) / AppSize.s100,
        ),
        Text(
          authTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: mediaQueryHeight(context) / AppSize.s120),
        Text(
          authSubtitle,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: mediaQueryHeight(context) / AppSize.s20),
      ],
    );
  }
}
