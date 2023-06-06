
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant.dart';

void navigateTo({required context, required Widget widget}) =>
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));

void navigateReplacementTo({required context, required Widget widget}) =>
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => widget));

Widget defaultTextButton(
    {required VoidCallback onPressed, required String text}) =>
    TextButton(onPressed: onPressed, child: Text(text.toUpperCase()));

// Widget defaultTextField(
//     {
//       required TextEditingController controller,
//       required VoidCallback  validator,
//       required String label,
//       required Widget prefixIcon,
//        Widget? suffixIcon,
//        bool? obscureText,
//     }) =>
//     TextFormField
// (
// obscureText: obscureText??false ,
// controller:controller ,
// validator:(value){validator;},
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// labelText: label,
// prefixIcon: suffixIcon,
// suffixIcon:suffixIcon ,
// ),
//     );

Widget defaultMaterialButton({required String text,required VoidCallback onPressed }){
  return Material(
    color:defaultColor,
    borderRadius: BorderRadius.circular(10.0),
    child: MaterialButton(
      color:defaultColor,

      height: 40,
      minWidth: double.infinity,
      child: Text(text.toUpperCase(),style: TextStyle(color: Colors.white),),
      onPressed: onPressed,
    ),
  );
}


void flutterToast ({required String msg,required ToastState state }) {
   Fluttertoast.showToast(
        msg: msg,
     timeInSecForIosWeb: 5,
     backgroundColor: ChooseColor(state) ,
     toastLength: Toast.LENGTH_LONG,

      );
}


enum ToastState{
  SUCCESS,
  ERROR,
  WARNING,
}

Color ChooseColor (ToastState state){
  Color? color;
  switch(state){
    case ToastState.SUCCESS : color=Colors.green;break;
    case ToastState.ERROR : color=Colors.red;break;
    case ToastState.WARNING : color=Colors.yellow;break;
  }
  return color ;
}