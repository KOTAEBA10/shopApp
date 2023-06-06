
class CategoriesModel{
  late bool status;
  Data? data;
CategoriesModel.fromJson(Map<String,dynamic>json){
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
  late String name;
  late String image;
  DataList.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}