
class UpdateProfileModel{
  late  bool status;
   String? message;
  Data? data ;

  UpdateProfileModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null?  Data.fromJson(json['data']):null;
  }

}
class Data {
  late int id;
   String? name;
   String? email;
   String? phone;
   String? image;
  late int points;
  late int credit;
  late String token;

  Data.fromJson(Map<String, dynamic>json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['message'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}