import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/routs_manager.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/view_model/cubit/cubit.dart';
import '../../layout/view_model/cubit/state.dart';
import '../../resources/component.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {



  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  XFile? _image;
  static final formKey = GlobalKey<FormState>();
  static final nameController = TextEditingController();
  static final emailController = TextEditingController();
  static final phoneController = TextEditingController();

  Future getImageFromGallery()async{
     _image = await ImagePicker().pickImage(source: ImageSource.gallery);


    setState(() {

      _image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is UpdateSuccessState)
            {
              if(state.userModel.status!)
                {
                  navigateAndFinish(context, Routes.profileRouts);
                }
            }
        },
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
         // final String image;
          nameController.text = cubit.userModel!.data!.name!;
          emailController.text = cubit.userModel!.data!.email!;
          phoneController.text = cubit.userModel!.data!.phone!;
         // image = cubit.userModel!.data!.image!;
          return ConditionalBuilder(
            condition:cubit.userModel!.data !=null ,
            builder: (context) =>Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.profile),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only( right: 10),
                    child: TextButton(
                      child: Text(
                        AppStrings.update,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.white,
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
                  )



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
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            SizedBox(height: 20,),
                            CircleAvatar(
                              radius: AppSize.s50,
                              backgroundColor:
                              Colors.deepPurpleAccent,
                              child: CircleAvatar(
                                  radius: AppSize.s60,
                                  backgroundImage: _image == null?
                                  null: FileImage(File(_image!.path))
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                getImageFromGallery();
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
                        ),


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


                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback:(context) =>Center(child: CircularProgressIndicator()) ,
          );
        });
  }
}
