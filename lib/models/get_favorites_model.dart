
class GetFavoritesModel{
  late bool status;
  Data? data;
  GetFavoritesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=Data.fromJson(json['data']);
  }
}
class Data{
 late int currentPage;
 List<DataList> data=[];
 Data.fromJson(Map<String,dynamic>json){
   currentPage=json['current_page'];
   json['data'].forEach((e){
     data.add(DataList.fromJson(e));
   });
 }
}
class DataList{
  late int id;
  Product? product;
  DataList.fromJson(Map<String,dynamic>json){
    id=json['id'];
    product=Product.fromJson(json['product']);
  }
}
class Product{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }

}