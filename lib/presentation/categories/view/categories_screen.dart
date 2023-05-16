import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/view_model/cubit/cubit.dart';
import '../../layout/view_model/cubit/state.dart';
import '../../resources/component/component.dart';
import '../view_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
      ),
    );
  }

  Widget buildCatItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}
