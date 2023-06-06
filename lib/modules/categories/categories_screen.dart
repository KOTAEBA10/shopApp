import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var categoriesModel = ShopAppCubit.get(context).categoriesModel;
        return
          Scaffold(
            body:categoriesModel!=null ? ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount:categoriesModel.data!.data.length,
              separatorBuilder:(context,index)=>Divider(),
              itemBuilder: (context,index){
                return Container(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                      image: NetworkImage(categoriesModel.data!.data[index].image),
                      height: 150,
                      width: 150,
                      ),
                      Text(categoriesModel.data!.data[index].name,maxLines: 1,style: TextStyle(fontSize:25,fontWeight: FontWeight.w800),),
                      Icon(Icons.forward)
                    ],
                  ),
                );
              },):Center(child: LinearProgressIndicator(),)
          );
      },
    );
  }
}
