import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/data/network/cache_helper.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/constants.dart';
import '../../layout/shop_layout.dart';
import '../../layout/shop_layout.dart';
import '../../resources/component.dart';
import '../../resources/routs_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../view_model/cubit/login_cubit.dart';
import '../view_model/cubit/states.dart';

class ShopLoginView extends StatelessWidget {
  const ShopLoginView({Key? key}) : super(key: key);

  static final _formKey = new GlobalKey<FormState>();
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopLoginSuccessState) {
              if (state.loginModel.status) {
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token,
                ).then((value) {
                  token = state.loginModel.data.token!;
                  navigateAndFinish(
                    context,
                    ShopLayout(),
                  );
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
            return Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppPadding.p15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const LogoWidget(),
                        const AuthTitleAndSubtitle(
                          authTitle: AppStrings.login,
                          authSubtitle: AppStrings.login,
                        ),
                        defultTextFormField(
                          controller: emailController,
                          label: AppStrings.email,
                         // hint: AppStrings.email,
                          hintColor: ColorManager.lightGrey,
                          inputType: TextInputType.emailAddress,
                          textDirection: TextDirection.ltr,
                          isObsecured: false,
                          validator: (email) {
                            if (email!.isEmpty) {
                              return 'Please Enter Your Email Address';
                            } else if (!EmailValidator.validate(email)) {
                              return 'Enter a valid email';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(height: mediaQueryHeight(context) / AppSize.s28),
                        defultTextFormField(
                          isObsecured: ShopLoginCubit.get(context).isPassword,
                          suffixIcon: IconButton(
                              color: Colors.white,
                              icon: ShopLoginCubit.get(context).isPassword
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: ColorManager.primary,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: ColorManager.primary,
                                    ),
                              onPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              }),
                          controller: passwordController,
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
                                    color: ColorManager.error,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQueryHeight(context) / AppSize.s80,
                        ),
                        ConditionalBuilder(
                            condition: (state is ShopLoginLoadingState),
                            builder: (context) =>
                                const CircularProgressIndicator(),
                            fallback: (context) => MainButton(
                                  title: AppStrings.login,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text.trim(),
                                          password: passwordController.text);
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
                                text: ' ${AppStrings.signUp}',
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    /*   navigateTo(
                                            context: context,
                                            screenRoute: Routes.registerScreen);*/
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

/*builder:(context,state){
            return Center(
              child: SingleChildScrollView(
                padding:  EdgeInsets.all(AppPadding.p15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /*const LogoWidget(),
                      const AuthTitleAndSubtitle(
                        authTitle: AppStrings.login,
                        authSubtitle: AppStrings.pleaseLogin,
                      ),*/
                      defultTextFormField(
                        controller: emailController,
                        label: AppStrings.email,
                        hint: AppStrings.email,
                        hintColor: ColorManager.lightGrey,
                        inputType: TextInputType.emailAddress,
                        textDirection: TextDirection.ltr,
                        isObsecured: false,
                        validator: (email) {
                          if(email!.isEmpty){
                            return 'Please Enter Your Email Address';
                          }else if(!EmailValidator.validate(email))
                          {
                            return 'Enter a valid email';
                          }else
                            return null;
                        },
                      ),
                      SizedBox(height: mediaQueryHeight(context) / AppSize.s28),
                      defultTextFormField(
                        isObsecured:ShopLoginCubit.get(context).isPassword ,
                        suffixIcon: IconButton(
                            color: Colors.white,
                            icon: ShopLoginCubit.get(context)
                                .isPassword?Icon(Icons.visibility_off,color: ColorManager.primary,):
                            Icon(Icons.visibility,color: ColorManager.primary,),
                            onPressed: (){
                              ShopLoginCubit.get(context).changePasswordVisibility();
                            }),
                        controller: passwordController,
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
                              color: ColorManager.error,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaQueryHeight(context) / AppSize.s80,
                      ),
                      ConditionalBuilder(condition:(state is ShopLoginLoadingState),
                          builder: (context)=>const CircularProgressIndicator(),
                          fallback: (context)=>MainButton(
                            title: AppStrings.login,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text);
                              }
                            },
                          )
                      ),
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
                                  text: ' ${AppStrings.signUp}',
                                  style: TextStyle(
                                      color: ColorManager.primary,
                                      fontWeight: FontWeight.bold
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                   /*   navigateTo(
                                          context: context,
                                          screenRoute: Routes.registerScreen);*/
                                    },
                                ),
                              ],
                            ),
                          )),

                    ],
                  ),
                ),
              ),
            );
          },*/
