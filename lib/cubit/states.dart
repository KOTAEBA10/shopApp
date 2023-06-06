
import '../models/update_profile.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates{}

//================BottomNav=====================================

class ShopAppChangeBottomNavState extends ShopAppStates{}

//================BottomNav End=====================================

//================HomeModel=====================================

class ShopAppHomeLoadingState extends ShopAppStates{}
class ShopAppHomeSuccessState extends ShopAppStates{}
class ShopAppHomeErrorState extends ShopAppStates{
  final String error ;
  ShopAppHomeErrorState(this.error);
}

//================HomeModelEnd=====================================

//================CategoryModel=====================================

class ShopAppCategoryLoadingState extends ShopAppStates{}
class ShopAppCategorySuccessState extends ShopAppStates{}
class ShopAppCategoryErrorState extends ShopAppStates{
  final String error ;
  ShopAppCategoryErrorState(this.error);
}

//================CategoryModel End=====================================

//================Settings=====================================

class ShopAppSettingsLoadingState extends ShopAppStates{}
class ShopAppSettingsSuccessState extends ShopAppStates{}
class ShopSettingsErrorState extends ShopAppStates{
  final String error ;
  ShopSettingsErrorState(this.error);
}

//================SettingsModel=====================================

//================Update Profile=====================================

class ShopAppUpdateProfileLoadingState extends ShopAppStates{}
class ShopAppUpdateProfileSuccessState extends ShopAppStates{
  UpdateProfileModel? updateProfileModel;
  ShopAppUpdateProfileSuccessState(this.updateProfileModel);
}
class ShopUpdateProfileErrorState extends ShopAppStates{
  final String error ;
  ShopUpdateProfileErrorState(this.error);
}

class ClearDataState extends ShopAppStates{}

//================Update Profile End=====================================


//================Favorites post=====================================

class ShopAppChangeFavoritesIconState extends ShopAppStates{}
class ShopAppFavoritesSuccessState extends ShopAppStates{}
class ShopAppFavoritesErrorState extends ShopAppStates{
  final String error;
  ShopAppFavoritesErrorState(this.error);
}

//================Favorites Post End=====================================


//================Get Favorites post=====================================
class ShopAppLoadingGetFavoritesState extends ShopAppStates{}
class ShopAppSuccessGetFavoritesState extends ShopAppStates{}
class ShopAppErrorGetFavoritesState extends ShopAppStates{
  final String error;
  ShopAppErrorGetFavoritesState(this.error);
}

//================Get Favorites Post End=====================================

