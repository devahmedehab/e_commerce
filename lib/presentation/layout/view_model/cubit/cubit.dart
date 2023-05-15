import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce/presentation/layout/view_model/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/constants.dart';
import '../../../../data/network/dio_helper.dart';
import '../../../auth/login/view_model/login_model.dart';
import '../../../categories/view/categories_screen.dart';
import '../../../categories/view_model/categories_model.dart';
import '../../../favorites/view/favorites_screen.dart';
import '../../../favorites/view_model/change_fav_model.dart';
import '../../../favorites/view_model/fav_model.dart';
import '../../../products/products_screen.dart';
import '../../../resources/component.dart';
import '../../../resources/end_point.dart';
import '../../../resources/strings_manager.dart';
import '../layout_model.dart';

class ShopCubit extends Cubit<ShopStates> {

  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [

    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),

  ];

  void changeBottom(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  LayoutModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = LayoutModel.fromJson(value.data);

      // printFullText(homeModel.data.banners[0].image);
      // print(homeModel.status);

      homeModel?.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      // printFullText(homeModel.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesModel() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {


      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavModel ? changeFavModel;


  void changeFavorites(int productId) {

    favorites[productId]  !=favorites[productId];
    emit(ShopChangeFavoritesState());


    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      print(value.data);

      if(changeFavModel?.status!= null){
        favorites[productId]  != favorites[productId];

      }else{
        getFavoritesModel();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavModel!));

    }).catchError((error){

      favorites[productId]  !=favorites[productId];

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel ?favoritesModel;
  void getFavoritesModel()
  {
    emit(ShopLoadingGetFavoritesState());


    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavState());
    });
  }
   LoginModel? userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());


    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);

      printFullText(userModel!.data!.name!);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void status = showToast(
      text: AppStrings.connecting,
      state: ToastStates.SUCCESS);

  late StreamSubscription _streamSubscription;
  Connectivity  _connectivity =Connectivity();

  void checkRealtimeConnection()async{
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if(event ==ConnectivityResult.mobile){
        status = showToast(
            text: AppStrings.connectionSuccess,
            state: ToastStates.SUCCESS);
      }else if(event ==ConnectivityResult.wifi){
        status = showToast(
            text: AppStrings.connectionSuccess,
            state: ToastStates.SUCCESS);
      }else{
        status=showToast(
            text:AppStrings.notConnected ,
            state: ToastStates.ERROR);
      }

    });
  }






}
