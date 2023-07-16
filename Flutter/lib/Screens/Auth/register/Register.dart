import 'package:attendencesystem/Screens/Homes/doctorhome.dart';
import 'package:attendencesystem/shared/Componnents/componnets.dart';
import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:attendencesystem/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var level_idController = TextEditingController();
  var department_id_idController = TextEditingController();
  var phoneController = TextEditingController();
  var fixedHieght;
  var fixedWidth;

  @override
  Widget build(BuildContext context) {
    fixedHieght = MediaQuery.of(context).size.height;
    fixedWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterDataSuccessState) {
            if (state.registerModel.status == true) {
              Fluttertoast.showToast(
                msg: state.registerModel.message.toString(),
                backgroundColor: Colors.green,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
              );
              CacheHelper.setData(
                      key: 'token', value: state.registerModel.token)
                  .then((value) {
                userToken = state.registerModel.token;
                navigateAndFinish(context, DoctorHome());
              });
            } else {
              Fluttertoast.showToast(
                msg: state.registerModel.message.toString(),
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
              );
            }
          } else if (state is RegisterDataErrorState) {
            Fluttertoast.showToast(
                msg: 'something  occurred ',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Level Id:\nLevel1:10\nLevel2:11\nLevel3:12\nLevel4:13",style: TextStyle(color: Colors.grey),),
                            Text("Department Id:\nDepartment:4\Department:6\nDepartment:7\nDepartment:8",style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          ' ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: fixedHieght * 20 / fixedHieght,
                        ),
                        defaultFormField(
                            label: Text('name'),
                            prefix: Icons.person,
                            controller: nameController,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'name can not be empty';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress),
                        SizedBox(
                          height: fixedHieght * 20 / fixedHieght,
                        ),  defaultFormField(
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
                          height: fixedHieght * 20 / fixedHieght,
                        ),
                        defaultFormField(
                          label: Text('Password'),
                          prefix: Icons.lock_open_outlined,
                          suffix: RegisterCubit().get(context).suffixIcon,
                          obscuredText: RegisterCubit().get(context).isObscure,
                          onIconPressed: () {
                            RegisterCubit()
                                .get(context)
                                .changeSuffixVisibility();
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
                          height: fixedHieght * 20 / fixedHieght,
                        ),
                        defaultFormField(
                          label: Text('Level Id'),
                          prefix: Icons.perm_identity_sharp,
                          controller: level_idController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Level Id can not be empty';
                            }
                            return null;
                          },
                          type: TextInputType.number,
                        ),
                        SizedBox(
                          height: fixedHieght * 20 / fixedHieght,
                        ),
                        defaultFormField(
                          label: Text('Department Id'),
                          prefix: Icons.account_balance_wallet_sharp,
                          controller: department_id_idController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Department Id can not be empty';
                            }
                            return null;
                          },
                          type: TextInputType.name,
                        ),
                        SizedBox(
                          height: fixedHieght * 20 / fixedHieght,
                        ),
                        SizedBox(
                          height: fixedHieght * 20 / fixedHieght,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterDataLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 50,
                            color: kPrimarycolor,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit().get(context).postRegisterData(
                                      level_id: level_idController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      department_id: department_id_idController.text,
                                  );
                                }
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
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
