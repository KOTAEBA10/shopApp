import 'package:dio/dio.dart';


class DioHelper{

 static Dio? dio;

static init(){
  dio= Dio(BaseOptions(
    baseUrl: 'https://student.valuxapps.com/api/',
    receiveDataWhenStatusError: true,
  ));
}

//==================Get Data======================================

static  Future<Response>getData({
  String lang = 'ar',
  String? token,
  Map<String, dynamic>? query,
  required String path,
}){
  dio!.options.headers={
    'lang':lang,
    'Content_type':'application/json',
    'Authorization':token
  };
  return dio!.get(path);
}

//==================Post Data======================================

 static Future<Response> postData({
  required String url,
   required Map<String,dynamic> data,
   Map<String,dynamic>? query,
   String? lang='ar',
   String? token,
})async{
  dio!.options.headers={
    'lang':lang ,
    'Content-Type':'application/json',
    'Authorization':token,
  };
  return await dio!.post(
   url,
  data:data,
    queryParameters: query,
  );
 }

//==================Put Data======================================


static Future<Response> putData({
  required String url,
  required Map<String,dynamic> data,
  Map<String,dynamic>? query,
  String? lang='ar',
  String? token,
}){
  dio!.options.headers={
    'lang':lang ,
    'Content-Type':'application/json',
    'Authorization':token,
  };
  return dio!.put(url,data: data,queryParameters: query);
}

}