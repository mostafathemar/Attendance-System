import 'package:attendencesystem/Screens/Auth/register/Register.dart';
import 'package:attendencesystem/Screens/lectures/user_Lecture_Details.dart';
import 'package:attendencesystem/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../shared/Componnents/componnets.dart';
import '../../../../shared/Componnents/constants.dart';
import '../../../../shared/Componnents/customButton.dart';
import '../../../Homes/Studenthome.dart';
import '../../doctorlogin/logIn/doctor_login.dart';
import 'cubit/UserCubit.dart';
import 'cubit/Userstates.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var userEmailController = TextEditingController();
  var userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSeconderycolor,
      body: BlocProvider(
        create: (context) => UserLoginCubit(),
        child: BlocConsumer<UserLoginCubit, UserLoginStates>(
            builder: (BuildContext context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Form(
                  key: formKey,
                  child: ListView(

                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, DoctorLogInPage());
                                },
                                child: Text(
                                  'Login as Doctor',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                )),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/Icon.jpeg',
                        height: 150,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Attendence System",
                            style: TextStyle(
                              color: kPrimarycolor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 75,
                      ),
                      Row(
                        children: [
                          Text(
                            "LOGIN",
                            style:
                                TextStyle(color: kPrimarycolor, fontSize: 25),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          label: Text('Email'),
                          prefix: Icons.email,
                          controller: userEmailController,
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
                        suffix: UserLoginCubit().get(context).userSuffixIcon,
                        obscuredText:
                            UserLoginCubit().get(context).userIsObscure,
                        onIconPressed: () {
                          UserLoginCubit()
                              .get(context)
                              .changeUserSuffixVisibility();
                        },
                        prefix: Icons.lock_open_outlined,
                        controller: userPasswordController,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'password can not be empty';
                          }
                          return null;
                        },
                        type: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            UserLoginCubit()
                                .get(context)
                                .postLoginData(
                                email: userEmailController.text,
                                password:
                                userPasswordController.text);

                          }

                        },
                        child: CustomButton(
                          ButtonName: 'LogIn',
                          color: Color(0xff0089DB),
                          condition:
                          state is! UserLoginDataLoadingState,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                           navigateTo(context, RegisterPage());
                          },
                          child: Text('don`t have an account ? \t Register',
                              style: TextStyle(color: Colors.black))),
                      SizedBox(
                        height: 75,
                      ),
                    ],
                  ),
                ),
              );
            },
          listener: (context, state) {
            if (state is UserLoginDataSuccessState) {
              if (state.loginModel.status == true) {
                Fluttertoast.showToast(
                  msg: state.loginModel.message.toString(),
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                );
                CacheHelper.setData(
                    key: 'api_token',
                    value: state.loginModel.token)
                    .then((value) {
                  userToken = state.loginModel.token;
                  navigateTo(context, StudentHome());
                  print("userToken========${userToken}");
                });

              }

              else if(state.loginModel.status == false) {
                Fluttertoast.showToast(
                  msg: state.loginModel.message.toString(),
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                );
              }
            }





            else if (state is UserLoginDataErrorState) {
              Fluttertoast.showToast(
                  msg: 'Auth failed ,something error with email or password. ',
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3);
            }
          },


        ),
      ),
    );
  }
}
