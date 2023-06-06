import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

//------------------Init-------------------------------------------------------------


   static  init() async {
     sharedPreferences = await SharedPreferences.getInstance();
  }

//------------------Save Data-------------------------------------------------------------

  static Future<bool>? saveData({required String key,required dynamic value})async{
    if(value is String) return await sharedPreferences!.setString(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);
    if(value is int) return await sharedPreferences!.setInt(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

//-----------------Get Data End--------------------------------------------------------------

  static dynamic getData({required String key}){
    return sharedPreferences!.get(key);
  }

//-----------------------Remove Data---------------------------------------------------------

 static Future<bool> removeData({required String key})async{
     return await sharedPreferences!.remove(key);
 }

}
