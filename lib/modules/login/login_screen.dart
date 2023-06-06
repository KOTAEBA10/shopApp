import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../component/component.dart';
import '../../constant.dart';
import '../../network/local.dart';
import '../register/register_screen.dart';
import '../shop/shop_screen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';


class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, states) {
          if (states is LoginSuccessState) {
            if (!states.loginModel.status) {
              flutterToast(
                  msg: states.loginModel.message, state: ToastState.ERROR);
              // print(states.loginModel.message);
            } else
              CacheHelper.saveData(
                      key: 'token', value: states.loginModel.data!.token)!
                  .then((value) {
                if (value) {
                  TOKEN = states.loginModel.data!.token;
                  navigateReplacementTo(
                      context: context, widget: ShopAppScreen());
                }
              });
          }
        },
        builder: (context, states) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN..',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Email';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: cubit.isSecure,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Password';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: cubit.suffixIcon,
                          onPressed: () {
                            cubit.changeIcon();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (states is LoginLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultMaterialButton(
                        text: 'login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                          }
                        }),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Text('don\'t have account ?'),
                        defaultTextButton(
                            onPressed: () {
                              navigateTo(context:context ,widget: RegisterScreen());
                            },
                            text: 'click here')
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
