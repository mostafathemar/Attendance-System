import 'package:attendencesystem/Screens/Auth/doctorlogin/logIn/cubit/doctorstates.dart';
import 'package:attendencesystem/model/Doctor_Login_Model.dart';
import 'package:attendencesystem/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DoctorLoginCubit extends Cubit<DoctorLoginStates> {

  DoctorLoginCubit() :super(DoctorLoginInitialState());

  DoctorLoginCubit get(context) => BlocProvider.of(context);

  IconData doctorSuffixIcon = Icons.visibility;

  bool doctorIsObscure = true;

  changeDoctorSuffixVisibility() {
    doctorIsObscure = !doctorIsObscure;
    if (doctorIsObscure) {
      doctorSuffixIcon = Icons.visibility;
    } else {
      doctorSuffixIcon = Icons.visibility_off;
    }
    emit(DoctorSuffixVisibilityState());
  }
  DoctorLogin? doctorLogin;
  postDoctorLoginData({
    required String email,
    required String password,
  }){
    emit(DoctorLoginDataLoadingState());

    DioHelper.postData("https://omar-gradeuation-project.forloop-eg.com/api/doctor-login",
        data: {
      'email':email,
      'password':password,
    }).then((value)
    {
      doctorLogin = DoctorLogin.fromJson(value.data);
      emit(DoctorLoginDataSuccessState(doctorLogin!));
    }).catchError((error){
      print('this is my status${error.toString()}');
      print(error.toString());
      emit(DoctorLoginDataErrorState());
    });
  }

}