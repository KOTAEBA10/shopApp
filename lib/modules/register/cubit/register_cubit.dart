import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/modules/register/cubit/register_states.dart';

import '../../../models/register_model.dart';
import '../../../network/dio.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  //--------------------------------------------------------------

  bool isSecure = false;
  var suffixIcon = Icons.visibility;

  void changeIcon() {
    isSecure = !isSecure;
    isSecure
        ? suffixIcon = Icons.visibility
        : suffixIcon = Icons.visibility_outlined;
    emit(RegisterChangeIconState());
  }

//-----------------------------------------------------------------------------

  RegisterModel? registerModel;

  void userRegister({required String name,required String phone,required String email,required String password,required String image,}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: 'register',
        data: {
          'name':name,
          'phone':phone,
          'email':email,
          'password':password,
          'image':image
        }).then((value) {
          registerModel=RegisterModel.fromJson(value.data);
          print(registerModel!.message);
          print(registerModel!.data!.token);

          emit(RegisterSuccessState(registerModel!));
    }).catchError((error){
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }
}
