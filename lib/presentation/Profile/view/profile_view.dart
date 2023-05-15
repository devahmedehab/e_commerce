import 'package:e_commerce/presentation/resources/assets_manager.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/routs_manager.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/constants.dart';
import '../../layout/view_model/cubit/cubit.dart';
import '../../layout/view_model/cubit/state.dart';
import '../../resources/component.dart';

class ProfileView extends StatelessWidget {
  static final formKey = GlobalKey<FormState>();
  static final nameController = TextEditingController();
  static final emailController = TextEditingController();
  static final phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          final String image;
          nameController.text = cubit.userModel!.data!.name!;
          emailController.text = cubit.userModel!.data!.email!;
          phoneController.text = cubit.userModel!.data!.phone!;
          image = cubit.userModel!.data!.image!;
          return Scaffold(
            appBar: AppBar(
              title: Text(AppStrings.profile),
              actions: [
                IconButton(
                  onPressed: (){
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
                      if (state is UpdateLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: AppSize.s40,
                      ),
                      CircleAvatar(
                          radius: AppSize.s50,
                          backgroundColor: Colors.deepPurpleAccent,
                          child: CircleAvatar(
                              radius: AppSize.s50,
                              backgroundImage: AssetImage(ImageAssets.male)
                            /*NetworkImage(image)*/
                          )
                      ),
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

                      MainButton(
                          title: AppStrings.logOut,
                          color: ColorManager.amber,
                          onPressed: (){
                            signOut(context);
                          }
                      ),



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
