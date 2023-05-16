import 'package:e_commerce/presentation/resources/assets_manager.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/routs_manager.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../resources/component/component.dart';
import '../../resources/component/log_out_section.dart';
import '../view_model/profile_cubit/profile_cubit.dart';
import '../view_model/profile_cubit/profile_state.dart';

class ProfileView extends StatelessWidget {
  static final formKey = GlobalKey<FormState>();
  static final nameController = TextEditingController();
  static final emailController = TextEditingController();
  static final phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          var cubit = ProfileCubit.get(context);
          final String image;
          nameController.text = cubit.profileModel!.data!.name!;
          emailController.text = cubit.profileModel!.data!.email!;
          phoneController.text = cubit.profileModel!.data!.phone!;
          image = cubit.profileModel!.data!.image!;
        },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
              title: Text(AppStrings.profile),
              actions: [
                IconButton(
                  onPressed: (){
                    ProfileCubit.get(context).getUserData();
                    navigateAndFinish(
                        context,
                        Routes.editProfileRouts
                    );
                  },
                  icon: Icon(Icons.edit_outlined,
                    color: ColorManager.white,
                  ),

                ),
              ],
            ),
            body: SingleChildScrollView(
              physics:BouncingScrollPhysics() ,
              child: Padding(
                padding:  EdgeInsets.all(AppPadding.p15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      Text(nameController.text,
                        style: TextStyle(color: ColorManager.primary,
                            fontSize: AppSize.s16),),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        isClickable: false,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return AppStrings.emailEmpty;
                          }
                        },
                        labelText: AppStrings.email,
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        isClickable: false,
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
                      SizedBox(
                        height: AppSize.s20,
                      ),

                      const LogOutSection(),



                      /*defaultButton(
                            function: () {
                              signOut(context);
                            },
                            text: 'Log Out',
                          ),*/
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}