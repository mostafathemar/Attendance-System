import 'package:attendencesystem/Screens/Homes/doctorhome.dart';
import 'package:attendencesystem/shared/Componnents/componnets.dart';
import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/Componnents/customButton.dart';
import '../../shared/network/local/cache_helper.dart';
import 'addImage.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterPage extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterDataSuccessState)
          {
            if(state.registerModel.status == true)
            {

              Fluttertoast.showToast(
                msg: state.registerModel.message!,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,

              );
              CacheHelper.setData(key: 'token', value: state.registerModel.data!.token).then((value){
                userToken =  state.registerModel.data!.token;
                navigateAndFinish(context, DoctorHome());
              });
            }
            else{
              Fluttertoast.showToast(
                msg:state.registerModel.message!,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
              );
            }
          }
          else if(state is RegisterDataErrorState){
            Fluttertoast.showToast(
                msg:'something error occurred ',
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          'Register now to see our hot offers ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          label: Text('Name'),
                          prefix: Icons.person,
                          controller: nameController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Name can not be empty';
                            }
                            return null;
                          },
                          type: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            label: Text('Email'),
                            prefix: Icons.email,
                            controller: emailController,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Email can not be empty';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          label: Text('Password'),
                          prefix: Icons.lock_open_outlined,
                          suffix: RegisterCubit().get(context).suffixIcon,
                          obscuredText: RegisterCubit().get(context).isObscure,
                          onIconPressed: () {
                            RegisterCubit().get(context).changeSuffixVisibility();
                          },
                          controller: passwordController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'password can not be empty';
                            }
                            return null;
                          },
                          type: TextInputType.visiblePassword,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterDataLoadingState,
                          builder: (context)=> Container(
                            width: double.infinity,
                            height: 50,
                            color: kPrimarycolor,
                            child: MaterialButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  RegisterCubit().get(context).postRegisterData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                  );
                                }
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          fallback:(context)=> Center(

                              child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
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