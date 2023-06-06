

class HomeModel{
  late bool status;
  Data? data;

  HomeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=Data.fromJson(json['data']);
  }
}

class Data{
  List<BannersModel> banners=[];
  List<ProductsModel> products=[];

  Data.fromJson(Map<String,dynamic>json){
    json['banners'].forEach((e){
      banners.add(BannersModel.fromJson(e));
    });
    json['products'].forEach((e){
      products.add(ProductsModel.fromJson(e));
    });
  }
}

class BannersModel{
 late int id;
 late String image;
 BannersModel.fromJson(Map<String,dynamic>json){
   id =json['id'];
   image =json['image'];
 }
}

class ProductsModel{
  late int id ;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;

  ProductsModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['oldPrice'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }


}