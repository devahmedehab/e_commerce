import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../presentation/resources/values_manager.dart';


void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );



void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;



}

class MainButton extends StatelessWidget {
  MainButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  final String title;
  final Function onPressed;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: AppSize.s60,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.p15),
          ),
          onPressed: () => onPressed(),
          color: color ?? ColorManager.primary,
          child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        ));
  }
}
/*
Widget buildListProduct( model, context,
    {
      bool isOldPrice =true,
    }) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.image,
                ),
                width: 120,
                height: 120,


              ),
              if (model.discount != 0&& isOldPrice)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red[700],
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price.round()} EG',
                      style: TextStyle(
                        fontSize: 13,
                        color: ColorManager.primary,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        '${model.oldPrice.round()} EG',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                        ShopCubit.get(context).favorites[model.id]
                            ? ColorManager.primary
                            : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}*/
