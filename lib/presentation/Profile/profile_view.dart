
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/constants.dart';
import '../layout/view_model/cubit/cubit.dart';
import '../layout/view_model/cubit/state.dart';
import '../resources/component.dart';

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
          //var model = ShopCubit.get(context).userModel;

          nameController.text = ShopCubit.get(context).userModel!.data!.name!;
          emailController.text = ShopCubit.get(context).userModel!.data!.email!;
          phoneController.text = ShopCubit.get(context).userModel!.data!.phone!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        //  return null;
                      },
                      labelText: 'Name',
                      prefix: Icons.person,
                    ),
                     SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                            //return null;
                          },
                          labelText: 'Email Address',
                          prefix: Icons.email,
                        ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      labelText: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                   MainButton(
                       title: 'Update',
                       color: ColorManager.amber,
                       onPressed: (){
                         if (formKey.currentState!.validate()) {
                           ShopCubit.get(context).updateUserData(
                             name: nameController.text,
                             phone: phoneController.text,
                             email: emailController.text,
                           );
                         }
                       }
                   ),
                    SizedBox(
                      height: 20,
                    ),
                    MainButton(
                        title: 'Log Out',
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
          );
        });
  }
}
