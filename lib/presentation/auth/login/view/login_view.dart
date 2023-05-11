import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/data/network/cache_helper.dart';
import 'package:e_commerce/presentation/resources/assets_manager.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/constants.dart';
import '../../../resources/component.dart';
import '../../../resources/routs_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../view_model/cubit/login_cubit.dart';
import '../view_model/cubit/states.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static final _formKey = new GlobalKey<FormState>();
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if (state.loginModel.status) {
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token,
                ).then((value) {
                  token = state.loginModel.data.token!;
                  Navigator.pushReplacementNamed(context, Routes.shopLayout);
                });
              } else {
                print(state.loginModel.message);

                showToast(
                  text: state.loginModel.message,
                  state: ToastStates.ERROR,
                );
              }
            }
          },

          builder: (context, state) {
            timeDilation=AppTime.t2;
            return Scaffold(

              body:  Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppPadding.p15),
                  child: Form(
                    key: LoginView._formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Hero(
                          tag: AppStrings.textTag,
                          child: Text(AppStrings.login,
                            style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: ColorManager.primary,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                fontSize: AppSize.s30
                            ),

                          ),
                        ),
                        SizedBox(height: AppSize.s50,),
                        defultTextFormField(
                          controller: LoginView.emailController,
                          label: AppStrings.email,
                          // hint: AppStrings.email,
                          hintColor: ColorManager.lightGrey,
                          inputType: TextInputType.emailAddress,
                          textDirection: TextDirection.ltr,
                          isObsecured: false,
                          validator: (email) {
                            if (email!.isEmpty) {
                              return AppStrings.usernameError;
                            } else if (!EmailValidator.validate(email)) {
                              return AppStrings.emailError;
                            } else
                              return null;
                          },
                        ),
                        SizedBox(height: mediaQueryHeight(context) / AppSize.s28),
                        defultTextFormField(
                          isObsecured: LoginCubit.get(context).isPassword,
                          suffixIcon: IconButton(

                              icon: LoginCubit.get(context).isPassword
                                  ? Icon(
                                Icons.visibility_off,
                                color: ColorManager.grey1,
                              )
                                  : Icon(
                                Icons.visibility,
                                color: ColorManager.primary,
                              ),
                              onPressed: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibility();
                              }),
                          controller: LoginView.passwordController,
                          label: AppStrings.password,
                          // hint: AppStrings.passwordExample,
                          hintColor: ColorManager.lightGrey,
                          inputType: TextInputType.visiblePassword,
                          textDirection: TextDirection.ltr,
                          validator: (value) {
                            if (value!.length < AppSize.s8) {
                              return AppStrings.enterValidPassword;
                            } else {
                              return null;
                            }
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              /*navigateTo(
                                  context: context,
                                  screenRoute: Routes.forgetPasswordScreen,
                                );*/
                            },
                            child: Text(
                              AppStrings.forgotPassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQueryHeight(context) / AppSize.s80,
                        ),
                        ConditionalBuilder(
                            condition: (state is LoginLoadingState),
                            builder: (context) =>
                            const CircularProgressIndicator(),
                            fallback: (context) => MainButton(
                              title: AppStrings.login,
                              onPressed: () {
                                if (LoginView._formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: LoginView.emailController.text.trim(),
                                      password: LoginView.passwordController.text);
                                }else{
                                  return null;
                                }
                              },
                            )),
                        SizedBox(height: mediaQueryHeight(context) / AppSize.s60),
                        Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppStrings.doNotHaveAccount,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  TextSpan(
                                    text: ' ${AppStrings.register}',
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        navigateTo(context, Routes.registerRoute);

                                      },
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}


