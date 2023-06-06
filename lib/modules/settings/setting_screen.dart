import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/component.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../network/local.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController( );
  var emailController=TextEditingController( );
  var phoneController=TextEditingController( );
  var imageController=TextEditingController( );
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){
        if(state is ShopAppUpdateProfileSuccessState){
          if(state.updateProfileModel!.status){
            flutterToast(msg: state.updateProfileModel!.message!, state:ToastState.SUCCESS);
            ShopAppCubit.get(context).getSettings();
          }else{
            flutterToast(msg: state.updateProfileModel!.message!, state:ToastState.ERROR);
          }
        }
      },
      builder: (context,state){
        var settingsModel = ShopAppCubit.get(context).settingsModel;
        return Scaffold(
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [

                    CircleAvatar(
                      radius: 80,
                      // backgroundImage: NetworkImage('${settingsModel!.data!.image}'),
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Name:'),
                        SizedBox(width: 10.0,),
                        Expanded(
                          child: TextFormField(
                            // initialValue:settingsModel!.data!.name ,
                            keyboardType: TextInputType.name,
                           controller: nameController,
                            validator:(value){
                              if(value!.isEmpty){
                                return 'please enter your name';
                              }
                            } ,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                             // labelText:'name' ,
                              hintText: settingsModel!.data!.name,
                              prefixIcon:Icon(Icons.person) ,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),

                    Row(
                      children: [
                        Text('Phone:'),
                        SizedBox(width: 10.0,),
                        Expanded(
                          child: TextFormField(
                            // initialValue:settingsModel.data!.phone ,
                            keyboardType: TextInputType.number,
                           controller: phoneController,
                            validator:(value){
                              if(value!.isEmpty){
                                return 'please enter your phone';
                              }
                            } ,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                             // labelText:'phone' ,
                              hintText: settingsModel.data!.phone,
                              prefixIcon:Icon(Icons.phone) ,
                            ),

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      children: [
                        Text('Image:'),
                        SizedBox(width: 10.0,),
                        Expanded(
                          child: TextFormField(
                            // initialValue:settingsModel.data!.image ,
                            keyboardType: TextInputType.name,
                           controller: imageController,
                            validator:(value){
                              if(value!.isEmpty){
                                return 'please enter your image';
                              }
                            } ,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText:'image' ,
                              hintText: settingsModel.data!.image,

                              prefixIcon:Icon(Icons.image) ,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      children: [
                        Text('email:'),
                        SizedBox(width: 10.0,),
                        Expanded(
                          child: TextFormField(
                            // initialValue:settingsModel.data!.email ,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator:(value){
                              if(value!.isEmpty){
                                return 'please enter your email';
                              }
                            } ,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText:'email' ,
                              hintText: settingsModel.data!.email,

                              prefixIcon:Icon(Icons.email) ,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    defaultTextButton(
                        onPressed: (){
                         if(formKey.currentState!.validate()) {
                            ShopAppCubit.get(context).updateProfile(
                                name: nameController.text.trim(),
                                phone: phoneController.text.trim(),
                                email: emailController.text.trim(),
                                image: imageController.text.trim()
                         );
                            if(state is ShopAppUpdateProfileSuccessState){
                              if(state.updateProfileModel!.status){
                               //  nameController.clear();
                               //  emailController.clear();
                               // phoneController.clear();
                               //  imageController.clear();
                                ShopAppCubit.get(context).clearFormFiled(nameController,emailController,imageController,phoneController);
                              }
                            }
                          }
                    }, text: 'Update'),

                    SizedBox(height: 20.0,),
                    defaultTextButton(onPressed: (){

                          CacheHelper.removeData(key: 'token').then((value) =>
                              navigateReplacementTo(
                                  context: context, widget: LoginScreen()));

                      }, text: 'logout'),
                  ],
                ),
              ),
            ),
          )
        );
      },
    );
  }
}
