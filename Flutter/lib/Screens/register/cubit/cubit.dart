import 'package:attendencesystem/Screens/register/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/register_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';

class RegisterCubit extends  Cubit<RegisterStates>
{
  RegisterCubit():super(RegisterInitialState());

  RegisterCubit get(context)=> BlocProvider.of(context);


  IconData suffixIcon = Icons.visibility;

  bool isObscure = true;

  changeSuffixVisibility()
  {
    isObscure =!isObscure;
    if(isObscure){
      suffixIcon = Icons.visibility;
    }else{
      suffixIcon = Icons.visibility_off;
    }
    emit(SuffixVisibilityRegisterState());
  }

  RegisterModel? registerModel;
  postRegisterData({
    String? name,
    String? email,
    String? password,
    String? phone,
})
  {
    emit(RegisterDataLoadingState());
    DioHelper.postData(REGISTER, data: {
      'name':name,
      'phone':phone,
      'password':password,
      'email':email
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print(registerModel!.data!.phone);
      emit(RegisterDataSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(RegisterDataErrorState());
    });
  }
}