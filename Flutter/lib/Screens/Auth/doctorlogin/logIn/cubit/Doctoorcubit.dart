import 'package:attendencesystem/Screens/Auth/doctorlogin/logIn/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorLoginCubit extends Cubit<LoginStates> {

  DoctorLoginCubit() :super(LoginInitialState());

  DoctorLoginCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility;

  bool isObscure = true;

  changeSuffixVisibility() {
    isObscure = !isObscure;
    if (isObscure) {
      suffixIcon = Icons.visibility;
    } else {
      suffixIcon = Icons.visibility_off;
    }
    emit(SuffixVisibilityState());
  }
  IconData doctorIdSuffixIcon = Icons.visibility;

  bool DoctorIdIsObscure = true;

  changeDoctorIdSuffixVisibility() {
    DoctorIdIsObscure = !DoctorIdIsObscure;
    if (DoctorIdIsObscure) {
      doctorIdSuffixIcon = Icons.visibility;
    } else {
      doctorIdSuffixIcon = Icons.visibility_off;
    }
    emit(SuffixVisibilityState());
  }
}