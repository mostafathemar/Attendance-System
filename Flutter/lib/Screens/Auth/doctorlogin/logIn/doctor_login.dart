import 'package:attendencesystem/Screens/Auth/doctorlogin/logIn/cubit/doctorcubit.dart';
import 'package:attendencesystem/Screens/Auth/doctorlogin/logIn/cubit/doctorstates.dart';
import 'package:attendencesystem/model/Doctor_Login_Model.dart';
import 'package:attendencesystem/model/Doctor_Login_Model.dart';
import 'package:attendencesystem/model/Doctor_Login_Model.dart';
import 'package:attendencesystem/shared/Componnents/customButton.dart';
import 'package:attendencesystem/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../model/Doctor_Login_Model.dart';
import '../../../../shared/Componnents/componnets.dart';
import '../../../../shared/Componnents/constants.dart';
import '../../../Homes/doctorhome.dart';

class DoctorLogInPage extends StatelessWidget {
  DoctorLogInPage({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var idController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorLoginCubit(),
      child: BlocConsumer<DoctorLoginCubit, DoctorLoginStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: kSeconderycolor,
            appBar: AppBar(
              backgroundColor: kSeconderycolor,
              elevation: 0.0,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/Icon.jpeg',
                            height: 150,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Attendence System',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            label: Text('Email'),
                            prefix: Icons.email_rounded,
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
                          suffix: DoctorLoginCubit().get(context).doctorSuffixIcon,
                          obscuredText:
                              DoctorLoginCubit().get(context).doctorIsObscure,
                          onIconPressed: () {
                            DoctorLoginCubit()
                                .get(context)
                                .changeDoctorSuffixVisibility();
                          },
                          prefix: Icons.lock_open_outlined,
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
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!
                                .validate()) {
                              DoctorLoginCubit()
                                  .get(context)
                                  .postDoctorLoginData(
                                  email: emailController.text,
                                  password:
                                  passwordController
                                      .text);
                            }
                          },
                          child: CustomButton(
                            ButtonName: 'LogIn',
                            color: Color(0xff0089DB),
                            condition:
                            state is! DoctorLoginDataLoadingState,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is DoctorLoginDataSuccessState) {
            if (state.doctorLogin.status == true) {
              Fluttertoast.showToast(
                msg: state.doctorLogin.message.toString(),
                backgroundColor: Colors.green,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
              );
              CacheHelper.setData(
                  key: 'api_token',
                  value: state.doctorLogin.token)
                  .then((value) {
                doctorToken = state.doctorLogin.token;
                navigateTo(context, DoctorHome());
                print("userToken========${doctorToken}");
              });

            }

            else if(state.doctorLogin.status == false) {
              Fluttertoast.showToast(
                msg: state.doctorLogin.message.toString(),
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
              );
            }
          }





          else if (state is DoctorLoginDataErrorState) {
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
    );
  }
}
