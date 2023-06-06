
class SearchModel {
   late bool status;
  Data? data;

  SearchModel.fromJsom(Map<String,dynamic>json){
    status=json['status'];
    data=json['data']!=null?Data.fromJsom(json['data']):null;
  }
}

class Data{
  late int currentPage;
  List<DataList> data=[];

  Data.fromJsom(Map<String,dynamic>json){
    currentPage=json['current_page'];
     json['data']= json['data'].forEach((e) {
        data.add(DataList.fromJsom(e));
      });
  }

}

class DataList{
  late int id;
  late dynamic price;
  late String image;
  late String name;
  late String description;
   bool? inFavorites;
   bool? inCart;

  DataList.fromJsom(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }


}