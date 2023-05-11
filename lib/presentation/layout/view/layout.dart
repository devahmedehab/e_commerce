import 'package:e_commerce/presentation/resources/assets_manager.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/profile/profile_view.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../../app/constants.dart';
import '../../resources/component.dart';
import '../../resources/routs_manager.dart';
import '../view_model/cubit/cubit.dart';
import '../view_model/cubit/state.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({Key? key}) : super(key: key);

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

final ZoomDrawerController z = ZoomDrawerController();
final emailController = TextEditingController();
final nameController = TextEditingController();

class _LayoutViewState extends State<LayoutView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        nameController.text = ShopCubit.get(context).userModel!.data!.name!;
        emailController.text = ShopCubit.get(context).userModel!.data!.email!;
        return ZoomDrawer(
            controller: z,
            borderRadius: 20,
            style: DrawerStyle.defaultStyle,
            showShadow: true,
            angle: -25.0,
            drawerShadowsBackgroundColor: Colors.blueGrey,
            slideWidth: MediaQuery.of(context).size.width * AppSize.s1,
            menuScreen: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(color: ColorManager.primary),
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 31,
                              backgroundColor: Colors.deepPurpleAccent,
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage(ImageAssets.backGround)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(nameController.text,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontFamily: '',
                                      )),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    emailController.text,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: '',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          navigateTo(
                            context,
                            Routes.profileRouts,
                          );
                        },
                      )),

                  //   myDivider(),
                  SizedBox(
                    height: 30,
                  ),
                  buildListTile("Main Screen", Icons.home_outlined, () {}),
                  SizedBox(
                    height: 15,
                  ),
                  buildListTile(
                      "Profile", Icons.account_box_outlined, ()  {
                    navigateTo(
                      context,
                      Routes.profileRouts,
                    );
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  buildListTile("Settings", Icons.settings_outlined, () {
                   // navigateTo(context, Routes.settingsRoute);
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  myDivider(),
                  SizedBox(
                    height: 15,
                  ),
                  buildListTile("Log out", Icons.logout_outlined, () {
                    signOut(context);
                  }),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            mainScreen: Scaffold(
              appBar: AppBar(
                title: Text(
                  AppStrings.appName,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      navigateTo(
                        context,
                        Routes.searchRouts,
                      );
                    },
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                ],
              ),
              body: cubit.bottomScreen[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeBottom(index);
                },
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: ColorManager.primary,
                      icon: Icon(
                        Icons.home,
                      ),
                      label: AppStrings.home),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.apps,
                      ),
                      label: AppStrings.categories),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      label: AppStrings.favorite),
                ],
              ),
            ));
      },
    );
  }
}
