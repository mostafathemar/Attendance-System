import 'package:attendencesystem/Screens/Auth/userlogin/logIn/cubit/Userstates.dart';
import 'package:attendencesystem/model/user_login_model.dart';
import 'package:attendencesystem/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserLoginCubit extends Cubit<UserLoginStates> {

  UserLoginCubit() :super(UserLoginInitialState());

  UserLoginCubit get(context) => BlocProvider.of(context);

  IconData userSuffixIcon = Icons.visibility;

  bool userIsObscure = true;

  changeUserSuffixVisibility() {
    userIsObscure = !userIsObscure;
    if (userIsObscure) {
      userSuffixIcon = Icons.visibility;
    } else {
      userSuffixIcon = Icons.visibility_off;
    }
    emit(UserSuffixVisibilityState());
  }


  IconData hospitalSuffixIcon = Icons.visibility;

  bool hospitalIsObscure = true;

  LoginModel2? loginModel;

  postLoginData({
    required String email,
    required String password,
  }){
    emit(UserLoginDataLoadingState());

    DioHelper.postData("https://omar-gradeuation-project.forloop-eg.com/api/student-login", data: {
      'email':email,
      'password':password,
    }).then((value)
    {
      loginModel = LoginModel2.fromJson(value.data);

      emit(UserLoginDataSuccessState(loginModel!));
    }).catchError((error){
      print('this is my status${error.toString()}');
      print(error.toString());
      emit(UserLoginDataErrorState());
    });
  }


}