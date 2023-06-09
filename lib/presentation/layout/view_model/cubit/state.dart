
import '../../../Profile/view_model/profile_model.dart';
import '../../../auth/login/view_model/login_model.dart';
import '../../../favorites/view_model/change_fav_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates
{

  final ChangeFavModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavState extends ShopStates{

}

class ShopErrorGetFavState extends ShopStates {}
class ShopLoadingUserDataState extends ShopStates {}
class ShopSuccessUserDataState extends ShopStates {

  final LoginModel userModel;

  ShopSuccessUserDataState(this.userModel);
}

class ShopErrorUserDataState extends ShopStates {}






