import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/view_model/cubit/cubit.dart';
import '../../layout/view_model/cubit/state.dart';
import '../../resources/component/component.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        },
      builder: (context, state) => ConditionalBuilder(
        condition: state is! ShopLoadingGetFavoritesState,
        builder:(context)=> ListView.separated(

          itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product,context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
        ),
        fallback: (context)=> Center(child: CircularProgressIndicator()),
      ),
    );
  }


}
