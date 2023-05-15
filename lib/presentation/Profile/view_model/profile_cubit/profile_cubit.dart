import 'dart:async';
import 'dart:io';
import 'package:e_commerce/presentation/Profile/view_model/profile_cubit/profile_state.dart';
import 'package:e_commerce/presentation/Profile/view_model/profile_model.dart';
import 'package:e_commerce/presentation/layout/view_model/layout_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/constants.dart';
import '../../../../data/network/dio_helper.dart';
import '../../../resources/end_point.dart';

class ProfileCubit extends Cubit<ProfileStates> {

  ProfileCubit() : super(ProfileInitialStates());

  static ProfileCubit get(context) => BlocProvider.of(context);


  ProfileModel? profileModel;

  void getUserData()
  {
    emit(ProfileLoadingUserDataState());


    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);

      printFullText(profileModel!.data!.name!);

      emit(ProfileSuccessUserDataState(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileUserDataErrorState());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
    String? image,

  })
  {
    emit(ProfileUpdateLoadingState());


    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
        'image' : image,
      },
    ).then((value) {

      profileModel = ProfileModel.fromJson(value.data);
      printFullText(profileModel!.data!.name!);

      emit(ProfileUpdateSuccessState(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileUpdateErrorState());
    });
  }




  File? profileImage;
  ImagePicker picker = ImagePicker();
  bool profileImageChanged = false;

  Future<void> getProfileImageGallery() async
      {
    await picker.pickImage(source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0).then((value) async {
      profileImage = File(value!.path);
      profileImageChanged = true;
      emit(ProfilePickedSuccessState());
    }).catchError((onError) {
      emit(ProfilePickedErrorState());
    });
  }

  void getProfileImageCamera() async {
    await picker.pickImage(source: ImageSource.camera).then((value) {
      profileImage = File(value!.path);
      emit(ProfilePickedSuccessState());
    }).catchError((onError) {
      emit(ProfilePickedErrorState());
    });
  }



}
