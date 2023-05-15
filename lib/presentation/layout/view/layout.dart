import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../app/constants.dart';
import '../../resources/assets_manager.dart';
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
  bool _hasInternet =false;
 // final String image;

  ConnectivityResult result = ConnectivityResult.none;

  RefreshController _refreshController = RefreshController();



  late StreamSubscription _streamSubscription;
  Connectivity  _connectivity =Connectivity();

  void checkRealtimeConnection()async{
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if(event ==ConnectivityResult.mobile){
        ShopCubit.get(context).status = showToast(
            text: AppStrings.connectionSuccess,
            state: ToastStates.SUCCESS);
      }else if(event ==ConnectivityResult.wifi){
        ShopCubit.get(context).status = showToast(
            text: AppStrings.connectionSuccess,
            state: ToastStates.SUCCESS);
      }else{
        ShopCubit.get(context).status=showToast(
            text:AppStrings.notConnected ,
            state: ToastStates.ERROR);
      }

    });
  }


  @override
  void initState() {
    checkRealtimeConnection();
    super.initState();
  }
  @override
  void dispose() {
    _streamSubscription.cancel();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        var model = ShopCubit.get(context).userModel!;
        emailController.text = model.data!.email!;
        nameController.text = model.data!.name!;
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ZoomDrawer(
            controller: z,
            borderRadius: 20,
            style: DrawerStyle.defaultStyle,
            showShadow: true,
            angle: -25.0,
            drawerShadowsBackgroundColor: ColorManager.primary,
            slideWidth: MediaQuery.of(context).size.width * AppSize.s1,
            menuScreen: Container(
              color: ColorManager.white,
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
                                  backgroundImage:  AssetImage(ImageAssets.male)


                            )
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
                  /*SizedBox(
                    height: 30,
                  ),
                  buildListTile("Main Screen", Icons.home_outlined, () {}),*/
                  SizedBox(
                    height: 30,
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
                    navigateTo(context, Routes.settingsRoute);
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
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    z.toggle!();
                  },
                ),
                backgroundColor: ColorManager.primary,
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
              body: SmartRefresher(
                child: cubit.bottomScreen[cubit.currentIndex],
                controller: _refreshController,
                onRefresh:() async {
                  await Future.delayed(Duration(microseconds: 500));
                  _refreshController.refreshFailed();

                  _hasInternet=await InternetConnectionChecker().hasConnection ;
                  final text = _hasInternet ? AppStrings.success: AppStrings.failed;
                  result= await Connectivity().checkConnectivity();

                  if(_hasInternet){
                    ShopCubit.get(context).getUserData();
                    ShopCubit.get(context).getFavoritesModel();
                    ShopCubit.get(context).getCategoriesModel();
                    showToast(
                        text: text,
                        state: ToastStates.SUCCESS
                    );
                  }
                  else {
                    showToast(
                        text: text,
                        state: ToastStates.ERROR

                    );

                  }
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: ColorManager.primary,
                backgroundColor: ColorManager.white,
                onTap: (index) {
                  cubit.changeBottom(index);
                },
                currentIndex: cubit.currentIndex,
                items: [

                  BottomNavigationBarItem(

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
            )
        );
      },
    );
  }
}
