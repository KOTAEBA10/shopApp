import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/category_model.dart';
import '../../models/home_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeModel = ShopAppCubit.get(context).homeModel;
        var categoriesModel = ShopAppCubit.get(context).categoriesModel;
        var favorites = ShopAppCubit.get(context).favorites;

        return Scaffold(
            body: homeModel != null
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            items: homeModel.data!.banners
                                .map((e) => Image(
                                      image: NetworkImage(e.image),
                                    ))
                                .toList(),
                            options: CarouselOptions(
                              height: 150,
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 500),
                              autoPlayCurve: Curves.easeIn,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Categories..',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 80,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categoriesModel!.data!.data.length,
                                itemBuilder: (context, index) {
                                  return categoryItem(
                                      categoriesModel.data!.data[index]);
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Products..',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: Colors.grey,
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1.3,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                homeModel.data!.products.length,
                                (index) => productItem(
                                    homeModel.data!.products[index],
                                    favorites,
                                    context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: LinearProgressIndicator(),
                    ),
                  ));
      },
    );
  }
}

Widget productItem(ProductsModel model, favorites, context) {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 4.0,
        ),
        Image(
          image: NetworkImage(model.image),
          height: 120,
        ),
        SizedBox(
          height: 5.0,
        ),
        Expanded(
            child: Text(
          model.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${model.price} \$',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: defaultColor),
              ),
              if (model.oldPrice != null)
                Text(
                  '${model.oldPrice}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              IconButton(
                icon: favorites[model.id]
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_outline),
                onPressed: () {
                  ShopAppCubit.get(context).postFavorites(productId: model.id);
                },
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget categoryItem(DataList model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          fit: BoxFit.contain,
        ),
        Container(
            color: Colors.black.withOpacity(0.7),
            child: Text(
              model.name,
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
