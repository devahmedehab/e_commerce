
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/presentation/resources/color_manager.dart';
import 'package:e_commerce/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../categories/view_model/categories_model.dart';
import '../layout/view_model/cubit/cubit.dart';
import '../layout/view_model/cubit/state.dart';
import '../layout/view_model/layout_model.dart';
import '../resources/component.dart';
import '../resources/values_manager.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavoritesState)
            {
              if(!state.model.status!)
                {
                  showToast(text: state.model.message!, state: ToastStates.ERROR);
                }
            }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => productBuilder(
                ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel, context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget productBuilder(LayoutModel? model, CategoriesModel? categoriesModel, context) =>

         SingleChildScrollView(
          
          physics: BouncingScrollPhysics(),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: model!.data!.banners
                      .map(
                        (e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.categories,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      //color: Colors.grey,
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                        itemCount: categoriesModel!.data!.data.length,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppStrings.products,
                      style: TextStyle(
                        fontSize: AppSize.s25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1 / 1.55,
                  children: List.generate(
                    model.data!.products.length,
                    (index) => buildGridProduct(model.data!.products[index],context),
                  ),
                ),
              ),
            ],
          ),
        );


  Widget buildCategoryItem(DataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image!),
          height: AppSize.s100,
          width: AppSize.s100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(
            .8,
          ),
          width: AppSize.s100,
          child: Text(
            model.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGridProduct(ProductModel model, context) => Container(
    
        color: ColorManager.white,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage((model.image!)),
                    width: double.infinity,
                    height: AppSize.s200,
                  ),
                  if (model.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p5),
                      color: ColorManager.red,
                      child: Text(
                        AppStrings.discount,
                        style: TextStyle(
                          fontSize: AppSize.s12,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: AppSize.s14, height: AppSize.s1_3),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()} ${AppStrings.eg}',
                          style: TextStyle(
                            fontSize: 13,
                            color: ColorManager.primary,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice.round()} ${AppStrings.eg}',
                            style: TextStyle(
                              fontSize: AppSize.s12,
                              color: ColorManager.darkGrey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: ()
                          {
                            ShopCubit.get(context).changeFavorites(model.id!);
                            print(model.id);
                          },
                          icon: CircleAvatar(
                            radius: AppSize.s15,
                            backgroundColor:ShopCubit.get(context).favorites[model.id]! ?ColorManager.primary : ColorManager.lightGrey,
                            child: Icon(
                              Icons.favorite_border,
                              size: AppSize.s18,
                              color: ColorManager.white,
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
}
