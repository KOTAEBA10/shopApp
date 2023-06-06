
class FavoritesModel{
  late bool status;
  late String message;
  Data? data;
  FavoritesModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message =json['message'];
    data=Data.fromJson(json['data']);
  }
}

class Data{
  late int id;
  Product? product;

  Data.fromJson(Map<String,dynamic>json){
    id = json['id'];
    product =Product.fromJson(json['product']);
  }
}

class Product{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;

  Product.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    price = json['old_price'];
    discount =json['discount'];
    image = json['image'];
  }

}