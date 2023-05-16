import 'package:e_commerce/app/constants.dart';
import 'package:e_commerce/data/network/cache_helper.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/component/component.dart';
import 'package:e_commerce/presentation/resources/font_manager.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:e_commerce/presentation/resources/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../routs_manager.dart';

class LogOutSection extends StatelessWidget {
  const LogOutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: AppSize.s20,
      leading: Icon(Icons.logout_outlined),
      title:  Text(
        AppStrings.logOut,
        style: TextStyle(fontSize: FontSize.s20, color: ColorManager.primary,),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              elevation: 24.0,
              title: Text(AppStrings.sure,
                  style: TextStyle(color: Colors.black)),
              content: Text(AppStrings.confirmLogOut,
                  style: TextStyle(color: Colors.black)),
              actions: [
                CupertinoDialogAction(
                  child: Container(
                    child: Text(
                      AppStrings.logOut,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  onPressed: () {

                    CacheHelper.removeData(key: 'token').then((value) {
                   //   CacheHelper.removeData(key: 'id');
                      navigateAndFinish(
                        context, Routes.loginRoute,
                      );
                    });
                  },
                ),
                CupertinoDialogAction(
                  child: Text('Cancel',
                      style: TextStyle(color: ColorManager.primary)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));


      },
    );
  }
}
