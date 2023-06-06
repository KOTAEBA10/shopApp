import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/get_favorites_model.dart';


class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var getFavoritesModel= ShopAppCubit.get(context).getFavoritesModel;
          var favorites= ShopAppCubit.get(context).favorites;

          return Scaffold(
            body:state is ShopAppLoadingGetFavoritesState? Center(child: LinearProgressIndicator(),)
             : ListView.separated(
              itemCount: getFavoritesModel!.data!.data.length,
              separatorBuilder: (context,index)=>Divider(),
                itemBuilder: (context,index){
                return  favoritesItem(getFavoritesModel.data!.data[index].product,favorites,context);
                },
            )
          );
        });
  }
}


Widget favoritesItem(Product? product, favorites,context){
  return Container(
    height: 150,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(product!.image),
                height: 150.0,
                width: 150.0,
              ),
              if(product.oldPrice!=null)
                Container(color: Colors.redAccent,child: Text('Discount',style: TextStyle(color: Colors.white),))

            ],
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container(
                  width: 200,
                  child: Text(product.name,maxLines: 2,overflow: TextOverflow.ellipsis,))),
              Row(
                children: [
                  Text('${product.price} \$    ',style: TextStyle(color: defaultColor),),
                  if(product.oldPrice!=null)
                    Text('${product.oldPrice} \$',
                      style: TextStyle(color: Colors.grey,decoration:TextDecoration.lineThrough ),),
                  IconButton(
                    icon:favorites[product.id]?Icon(Icons.favorite,color: Colors.red,) :Icon(Icons.favorite_outline),
                    onPressed: (){
                      ShopAppCubit.get(context).postFavorites(productId:product.id );
                    },)
                ],
              )
            ],
          )

        ],
      ),
    ),
  );
}
