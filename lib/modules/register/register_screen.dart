import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../component/component.dart';
import '../../constant.dart';
import '../../network/local.dart';
import '../login/login_screen.dart';
import '../shop/shop_screen.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var imageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,states){
          if(states is RegisterSuccessState){
            if (states.registerModel.status){
              CacheHelper.saveData(key:'token', value: states.registerModel.data!.token)!.then((value) {
                if(value){
                  TOKEN = states.registerModel.data!.token;
                  navigateTo(context: context, widget: ShopAppScreen());
                }
              }
              );
            }else{
              flutterToast(msg: states.registerModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context,states){
          var cubit=RegisterCubit.get(context);
          return
          Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('REGISTER...',style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter your name';
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person)),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter your name';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    SizedBox(height: 20.0,),

                    TextFormField(
                      controller: imageController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter your image';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Image',
                        prefixIcon: Icon(Icons.image),
                      ),
                    ),
                    SizedBox(height: 20.0,),

                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter your email';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 20.0,),

                    TextFormField(
                      obscureText: cubit.isSecure,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter your email';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(icon: Icon(cubit.suffixIcon),onPressed: (){cubit.changeIcon();},),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    if(states is RegisterLoadingState) LinearProgressIndicator(),
                    SizedBox(height: 20.0,),
                    defaultMaterialButton(text: 'Register',
                        onPressed: (){
                         if(formKey.currentState!.validate()) {
                              cubit.userRegister(
                                  name: emailController.text.trim(),
                                  phone: phoneController.text.trim().toString(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  image: imageController.text.trim());
                            }
                          }
                        ),
                    SizedBox(height: 5.0,),
                    Row(
                      children: [
                        Text('yau have account ?'),
                        defaultTextButton(onPressed: (){navigateTo(context: context, widget: LoginScreen());}, text: 'click here')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        },
      ),
    );
  }
}
