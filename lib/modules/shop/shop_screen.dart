import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/component.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../search/search-screen.dart';


class ShopAppScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener:(context,state){} ,
      builder:(context,state){
        var cubit= ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Shop App',style: TextStyle(color: Colors.black),),
            actions: [
              IconButton(onPressed: (){navigateTo(context: context, widget: SearchScreen());}, icon: Icon(Icons.search))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentIndex ,
            items: cubit.BottomItem,
            onTap:(index){cubit.onBottomChange(index);} ,
          ),
          body: cubit.body[cubit.currentIndex],
        );
      } ,
    );
  }
}

