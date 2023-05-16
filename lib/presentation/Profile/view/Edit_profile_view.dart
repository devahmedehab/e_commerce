import 'package:e_commerce/presentation/Profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:e_commerce/presentation/Profile/view_model/profile_cubit/profile_state.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/routs_manager.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../resources/component/component.dart';

class EditProfileView extends StatelessWidget {
  static final formKey = GlobalKey<FormState>();
  static final nameController = TextEditingController();
  static final emailController = TextEditingController();
  static final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
      if (state is ProfileUpdateSuccessState) {


      } else if (state is ProfileUpdateErrorState) {
      }
    }, builder: (context, state) {
      nameController.text = ProfileCubit.get(context).profileModel!.data!.name!;
      emailController.text =
          ProfileCubit.get(context).profileModel!.data!.email!;
      phoneController.text =
          ProfileCubit.get(context).profileModel!.data!.phone!;

      // final String image;

      // var cubit = ProfileCubit.get(context);

      // image = cubit.userModel!.data!.image!;
      return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.profile),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                child: Text(
                  AppStrings.update,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.white,
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ProfileCubit.get(context).getUserData();
                    navigateAndFinish(context, Routes.profileRouts);
                      ProfileCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                      );
                  }
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ProfileUpdateLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: AppSize.s40,
                  ),
                  /*Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          SizedBox(height: 20,),
                          CircleAvatar(
                            radius: AppSize.s50,
                            backgroundColor:
                            Colors.deepPurpleAccent,
                            child: CircleAvatar(
                                radius: AppSize.s60,
                                backgroundImage:NetworkImage(ImageAssets.splashLogo)
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                            },
                            icon: CircleAvatar(
                              radius: 18,
                              child: Icon(
                                Icons.camera_enhance,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),*/

                  SizedBox(
                    height: AppSize.s40,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return AppStrings.nameEmpty;
                      }
                      //  return null;
                    },
                    labelText: AppStrings.name,
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return AppStrings.emailEmpty;
                      }
                      //return null;
                    },
                    labelText: AppStrings.email,
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return AppStrings.phoneEmpty;
                      }
                      return null;
                    },
                    labelText: AppStrings.phone,
                    prefix: Icons.phone,
                  ),
                  /* ConditionalBuilder(
                        condition:(state is ProfileUpdateLoadingState) ,
                        builder: (context)=> const CircularProgressIndicator(),
                        fallback: (context) {
                          return Padding(
                            padding: const EdgeInsets.only( right: 10),
                            child:TextButton(
                              child: Text(
                                AppStrings.update,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.primary,
                                ),
                              ),
                              onPressed: (){
                                if (formKey.currentState!.validate()) {
                                  ShopCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                  );
                                }

                              },

                            ),
                          );
                        }
                      )*/
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
