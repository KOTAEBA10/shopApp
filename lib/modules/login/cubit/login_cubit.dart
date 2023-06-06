
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../models/login_model.dart';
import '../../../network/dio.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super (LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);
  
//-----------------------------------------------------------------------------------
  bool isSecure =false;
  var suffixIcon = Icon(Icons.visibility);
  void changeIcon (){
    isSecure =!isSecure;
    isSecure?suffixIcon=Icon(Icons.visibility):suffixIcon=Icon(Icons.visibility_outlined);
    emit(LoginChangeIconState());
  }


  //---------------------------------------------------------------------------------
  LoginModel? loginModel;
  
  void userLogin({required String email, required String password}){
    emit(LoginLoadingState());
    DioHelper.postData(url: 'login',
        data: {
      'email':email ,
      'password':password,
    }).then((value) {
      loginModel =LoginModel.fromJson(value.data);
      // print(loginModel!.message);
      // print(value.data);

      emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      print(error);
      emit(LoginErrorState(error.toString()));
    });
  }
}