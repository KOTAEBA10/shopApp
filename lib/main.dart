import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant.dart';
import 'cubit/cubit.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/shop/shop_screen.dart';
import 'network/dio.dart';
import 'network/local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  var onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  TOKEN = CacheHelper.getData(key: 'token') ?? null;
  print(TOKEN);
  Widget widget;
  if (onBoarding == true) {
    if (TOKEN != null) {
      widget = ShopAppScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppCubit()
        ..getHome()
        ..getCategories()
        ..getSettings()
        ..getFavorites(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: defaultColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              color: Colors.white,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.black),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.grey,
            ),
          ),
          home: widget,
        ),
      ),
    );
  }
}
