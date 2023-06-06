
class SettingsModel{
  late bool status;
  Data? data ;

  SettingsModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=Data.fromJson(json['data']);
  }
}

class Data{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  Data.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];

  }


}