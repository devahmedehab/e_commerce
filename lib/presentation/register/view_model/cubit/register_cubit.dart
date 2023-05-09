import 'package:e_commerce/data/network/dio_helper.dart';
import 'package:e_commerce/presentation/login/view_model/login_model.dart';
import 'package:e_commerce/presentation/register/view_model/cubit/register_states.dart';
import 'package:e_commerce/presentation/register/view_model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/end_point.dart';


class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit(): super(RegisterInitialState());

  static  RegisterCubit get(context) => BlocProvider.of(context);

 late LoginModel loginModel;




  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,


  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:{
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,


        },
    ).then((value) {
      print(value.data);
      loginModel= LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix =isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordVState());
  }
  IconData suffx = Icons.visibility_outlined;
  bool inPassword =true;

  void changePasswordVisibility2()
  {
    inPassword= !inPassword;
    suffx =inPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordV2State());
  }
  void sendOTP({
    required String email,

  }) {
    emit(SendOTPLoadingState());
    DioHelper.postData(
      url: SendOTP,
      data: {
        'email': email,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);





      emit(SendOTPSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(SendOTPErrorState(error.toString()));
    });}




}
