import 'package:e_commerce/data/network/dio_helper.dart';
import 'package:e_commerce/presentation/login/view_model/cubit/states.dart';
import 'package:e_commerce/presentation/login/view_model/login_model.dart';
import 'package:e_commerce/presentation/resources/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() :super (LoginInitialState());

  static  LoginCubit get(context) => BlocProvider.of(context );

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,

  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data:{
        'email':email,
        'password':password,
      },
    ).then((value) {
      print(value.data);
     loginModel= LoginModel.fromJson(value.data);
     emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix =isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordState());
  }
}
