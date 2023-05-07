import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Color ?color,

  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: (){function;},
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
   Color ?color ,
  bool isUpperCase = true,
  double radius = 20.0,
  required  Function function ,
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


