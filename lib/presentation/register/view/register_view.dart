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
import '../../../app/constants.dart';

import '../../resources/component.dart';
import '../../resources/routs_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../view_model/cubit/register_cubit.dart';
import '../view_model/cubit/register_states.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  static final _formKey = new GlobalKey<FormState>();
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final confirmPasswordController = TextEditingController();
  static final phoneController = TextEditingController();
  static final nameController = TextEditingController();

  
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              if (state.loginModel.status) {
               // print(state.loginModel.message);
              //  print(state.loginModel.data.token);

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
              body: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppPadding.p15),
                  child: Form(
                    key: RegisterView._formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Hero(
                          tag: AppStrings.textTag,
                          child: Text(AppStrings.register,
                            style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: ColorManager.primary,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                fontSize: 30
                            ),

                          ),
                        ),
                        SizedBox(height: AppSize.s50,),
                        defultTextFormField(

                          controller: RegisterView.nameController,
                          label: AppStrings.name,
                          // hint: AppStrings.email,
                          hintColor: ColorManager.lightGrey,
                          inputType: TextInputType.name,
                          textDirection: TextDirection.ltr,
                          isObsecured: false,
                          validator: (name) {
                            if (name!.isEmpty) {
                              return AppStrings.nameError;
                            }else
                              return null;
                          },
                          prefixIcon: Icon(Icons.person_outlined),

                        ),
                        SizedBox(
                          height: mediaQueryHeight(context) / AppSize.s80,
                        ),
                        defultTextFormField(
                          controller: RegisterView.emailController,
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
                        SizedBox(
                          height: mediaQueryHeight(context) / AppSize.s80,
                        ),
                        defultTextFormField(

                          controller: RegisterView.phoneController,
                          label: AppStrings.phone,
                          hintColor: ColorManager.lightGrey,
                          inputType: TextInputType.name,
                          textDirection: TextDirection.ltr,
                          isObsecured: false,
                          validator: (phone) {
                            if (phone!.isEmpty) {
                              return AppStrings.phoneError;
                            }else
                              return null;
                          },
                          prefixIcon: Icon(Icons.phone_outlined),

                        ),


                        SizedBox(height: mediaQueryHeight(context) / AppSize.s28),
                        defultTextFormField(
                          isObsecured: RegisterCubit.get(context).isPassword,
                          suffixIcon: IconButton(

                              icon: RegisterCubit.get(context).isPassword
                                  ? Icon(
                                Icons.visibility_off,
                                color: ColorManager.grey1,
                              )
                                  : Icon(
                                Icons.visibility,
                                color: ColorManager.primary,
                              ),
                              onPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              }),
                          controller: RegisterView.passwordController,
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
                        SizedBox(
                          height: mediaQueryHeight(context) / AppSize.s80,
                        ),

                        defultTextFormField(
                          isObsecured: RegisterCubit.get(context).inPassword,
                          suffixIcon: IconButton(

                              icon: RegisterCubit.get(context).inPassword
                                  ? Icon(
                                Icons.visibility_off,
                                color: ColorManager.grey1,
                              )
                                  : Icon(
                                Icons.visibility,
                                color: ColorManager.primary,
                              ),
                              onPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility2();
                              }),
                          controller: RegisterView.confirmPasswordController,
                          label: AppStrings.confirmPassword,
                          hintColor: ColorManager.lightGrey,
                          inputType: TextInputType.visiblePassword,
                          textDirection: TextDirection.ltr,
                          validator:  (value) {
                            if (value!.isEmpty) {
                              return AppStrings.passwordError;

                            }if(RegisterView.passwordController.text !=RegisterView.confirmPasswordController.text ){
                              return AppStrings.passwordError2;
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: mediaQueryHeight(context) / AppSize.s80,
                        ),
                        ConditionalBuilder(
                            condition: (state is RegisterLoadingState),
                            builder: (context) =>
                            const CircularProgressIndicator(),
                            fallback: (context) => MainButton(
                              title: AppStrings.register,
                              onPressed: () {
                                if (RegisterView._formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: RegisterView.nameController.text,
                                    email: RegisterView.emailController.text.trim(),
                                    password: RegisterView.passwordController.text,
                                    phone: RegisterView.phoneController.text,

                                  );


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
                                    text: AppStrings.alreadyHaveAccount,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  TextSpan(
                                    text: ' ${AppStrings.login}',
                                    style: TextStyle(
                                        color: ColorManager.primary,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        navigateAndFinish(context, Routes.loginRoute);

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


