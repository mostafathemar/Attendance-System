import 'package:attendencesystem/Screens/Auth/register/cubit/states.dart';
import 'package:attendencesystem/model/register_model.dart';
import 'package:attendencesystem/shared/network/remote/dio_helper.dart';
import 'package:attendencesystem/shared/network/remote/end_points.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


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
   required String level_id,
    required String email,
    required String password,
    String? department_id,
    String? name,
})
  {
    emit(RegisterDataLoadingState());
    DioHelper.postData('https://omar-gradeuation-project.forloop-eg.com/api/student-register',


        data: {
      'department_id':department_id,
      'name':name,
      'email':email,
      'password':password,
      'level_id':level_id,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print(registerModel?.message);
      emit(RegisterDataSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(RegisterDataErrorState());
    });
  }

http.StreamedResponse? model;
  postregister(
      String? level_id,
      String? email,
      String? password,
      String? department_id,
      ) async {
    var headers = {
      'Cookie': 'XSRF-TOKEN=eyJpdiI6InREV0VMS2d6QW1SSDVkaHdXOHoyUVE9PSIsInZhbHVlIjoibmZXZlYzL3EwenA5TVJKQmNvYVZvWHNkYXI2dFZ5ZnlCTlJmNW9QQ3dJR1RDOThWSHljQkRCZG1wdjNiY052RGo0WE45NVdocU1WT3k2ZUdpMWR5K0REY1Nmb2RzNGxVZnpwT0xDMzVOWXQ4QzFYNDl0MXRkbWZKSzZIMUhXRDYiLCJtYWMiOiI0NzNkNDA3NGU3NTM2ODhmYmQzZmZhMTNiOTZjMzIyYmNiODMxOGFmZjQ0MDg0NmIyZTAzYmMxN2Y5OGZmMzY5IiwidGFnIjoiIn0%3D; gradeuation_project_session=eyJpdiI6IlFnVkYxVkMwMk50M2VYZ29vYTVXOVE9PSIsInZhbHVlIjoiUG5GL0NBNEo3KzJlc3RNTDlCaU4xVWtvdkdOd2Q0aHZUUDVHUTVubmtDM1RNdzlWZ3dKcHpySzJLN204bHJBTUJCT2FtZk1xdjdmUWNubDhwU0w5bVFOVXBSTzNYQ2JFOWdVeXdkbStKOG5jZW1KMXp5aUZobm5KWEd2Z1FUTHciLCJtYWMiOiI4ZGRiNzhhOTgwMzUxODJhMWMyZjA1YzViMWNjZTljYzQyMjg5MDY3OTg0YWM4MGYwZWE1MjA5MTM3NDQ5Y2QxIiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://omar-gradeuation-project.forloop-eg.com/api/student-register'));
    request.fields.addAll({
      'name': 'student name',
      'email': '97936290212002@gmail.com',
      'password': '25617959',
      'level_id': '10',
      'department_id': '4'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }






}