import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/cubit/states.dart';

import '../constant.dart';
import '../models/category_model.dart';
import '../models/get_favorites_model.dart';
import '../models/home_model.dart';
import '../models/post_favorites_model.dart';
import '../models/setting_model.dart';
import '../models/update_profile.dart';
import '../modules/categories/categories_screen.dart';
import '../modules/favorites/favorites_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/settings/setting_screen.dart';
import '../network/dio.dart';


class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  //=======================Bottom Nav Bar============================================

  int currentIndex = 0;
  List<BottomNavigationBarItem> BottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.amp_stories_rounded), label: 'category'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
  ];

  void onBottomChange(index) {
    currentIndex = index;
    if (index == 2) {
      getFavorites();
    }
    emit(ShopAppChangeBottomNavState());
  }

  List<Widget> body = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

//=======================Bottom Nav Bar End============================================

//=======================Home Screen============================================

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHome() {
    emit(ShopAppHomeLoadingState());
    DioHelper.getData(path: 'home', token: TOKEN).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      // print(homeModel!.data!.products[0].name);
      emit(ShopAppHomeSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopAppHomeErrorState(error.toString()));
    });
  }

//=======================Home Screen End==============================================

//=======================Favorites Screen ============================================

  FavoritesModel? favoritesModel;

  void postFavorites({required int productId}) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopAppChangeFavoritesIconState());
    DioHelper.postData(
      url: 'favorites',
      data: {
        'product_id': productId,
      },
      token: TOKEN,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // print(favoritesModel!.message);
      if (favoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopAppFavoritesSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopAppFavoritesErrorState(error.toString()));
    });
  }

//=======================Favorites Screen End=========================================

  //======================= Get Favorites Screen =========================================

  GetFavoritesModel? getFavoritesModel;

  void getFavorites() {
    emit(ShopAppLoadingGetFavoritesState());
    DioHelper.getData(path: 'favorites', token: TOKEN).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      // print(getFavoritesModel!.status);
      emit(ShopAppSuccessGetFavoritesState());
    }).catchError((error) {
      print(error);
      emit(ShopAppErrorGetFavoritesState(error.toString()));
    });
  }

//=======================Get Favorites Screen End=========================================

//=======================Category Screen==============================================

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopAppCategoryLoadingState());
    emit(ShopAppHomeLoadingState());
    DioHelper.getData(path: 'categories', token: TOKEN).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.data!.data[0].name);
      emit(ShopAppCategorySuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopAppCategoryErrorState(error.toString()));
    });
  }

//=======================Category Screen End========================================

//=======================Settings Screen============================================

  SettingsModel? settingsModel;

  void getSettings() {
    emit(ShopAppLoadingGetFavoritesState());
    DioHelper.getData(path: 'profile', token: TOKEN).then((value) {
      settingsModel = SettingsModel.fromJson(value.data);
      // print(settingsModel!.status);
      emit(ShopAppSuccessGetFavoritesState());
    }).catchError((error) {
      print(error);
      emit(ShopAppErrorGetFavoritesState(error.toString()));
    });
  }

  //=======================Settings Screen(update profile)============================================

  UpdateProfileModel? updateProfileModel;

  void updateProfile({
    required String name,
    required String phone,
    required String email,
    required String image,
  }) {
    emit(ShopAppUpdateProfileLoadingState());
    DioHelper.putData(url: 'update-profile', token: TOKEN, data: {
      'email': email,
      'phone': phone,
      'name': name,
      'image': image,
    }).then((value) {
      updateProfileModel = UpdateProfileModel.fromJson(value.data);
      print(updateProfileModel!.message);
      emit(ShopAppUpdateProfileSuccessState(updateProfileModel));
    }).catchError((error) {
      print(error);
      emit(ShopUpdateProfileErrorState(error.toString()));
    });
  }

  void clearFormFiled(
      TextEditingController oneTextEditingController,
      TextEditingController twoTextEditingController,
      TextEditingController threeTextEditingController,
      TextEditingController fourTextEditingController) {
    oneTextEditingController.clear();
    twoTextEditingController.clear();
    threeTextEditingController.clear();
    fourTextEditingController.clear();
    emit(ClearDataState());
  }

//=======================Settings Screen(update profile) End============================================

//=======================Settings Screen============================================

}
