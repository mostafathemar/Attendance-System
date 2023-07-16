import 'package:attendencesystem/Cubit/states.dart';
import 'package:attendencesystem/model/CoursesLecture.dart';
import 'package:attendencesystem/model/doctor_attendace_model.dart';
import 'package:attendencesystem/model/doctor_get_courses.dart';
import 'package:attendencesystem/model/student_all_model.dart';
import 'package:attendencesystem/model/student_attendance.dart';
import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:attendencesystem/shared/network/remote/dio_helper.dart';
import 'package:attendencesystem/shared/network/remote/end_points.dart';
import 'package:attendencesystem/studentModel/studentallCourses.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppInitialState());

  AppCubit get(context) => BlocProvider.of(context);

  void fetchData(String url, Function onSuccess, Function onError, {String? token}) {
    emit(AppLoadingState());
    DioHelper.getData(
        url,
        query: {
          'status': true,
        }, token: token
    ).then((value) {
      print('Full response: ${value.data}');
      if (value.data is Map<String, dynamic>) {
        onSuccess(value.data);
        emit(AppSuccessState());
      } else {
        print('Error occurred: value.data is not a Map<String, dynamic>');
        onError();
        emit(AppErrorState());
      }
    }).catchError((error) {
      print('Error occurred: $error');
      onError();
      emit(AppErrorState());
    });
  }

  GetDoctorCourseModel? doctorCourses;
  getDoctorCourse() {
    fetchData(
      "https://omar-gradeuation-project.forloop-eg.com/api/doctor/courses",
          (data) {
        doctorCourses = GetDoctorCourseModel.fromJson(data);
        print("Course title: ${doctorCourses?.courses![1].title.toString()}");
      },
          () => print('Error in getDoctorCourse'),
      token: doctorToken,
    );
  }


  StudentAllCoursesModel? studentAllCoursesModel;
  getStudentAllCourse() {
    emit(StudentAllLoadingState());
print("sxscscscscsccscscs");
    DioHelper.getData(
        "https://omar-gradeuation-project.forloop-eg.com/api/student/courses",
        query: {
          'status': true,
        }, token: userToken
    ).then((value) {
      print('Full response: ${value.data}');
      if (value.data is Map<String, dynamic>) {
        studentAllCoursesModel = StudentAllCoursesModel.fromJson(value.data);
        print("Course title: ${studentAllCoursesModel?.courses![1].title.toString()}");
        emit(StudentAllSuccessState(studentAllCoursesModel));
      } else {
        print('Error occurred: value.data is not a Map<String, dynamic>');
        emit(StudentAllErrorState());
      }

      print("Course title: ${studentAllCoursesModel?.courses![1].title.toString()}");
      emit(StudentAllSuccessState(studentAllCoursesModel));
    }).catchError((error) {
      print('Error occurred: $error');
      emit(StudentAllErrorState());
    });
  }




  StuAllModel? stuAllModel;
  getStudentCourse(
      int id
      ) {

    emit(StudentCoursesLoadingState());
    print("sxscscscscsccscscs");
    DioHelper.getData(
        "https://omar-gradeuation-project.forloop-eg.com/api/doctor/course/$UserAttendantId/lectures",
        query: {
          'status': true,
        }, token: userToken
    ).then((value) {
      print('$UserAttendantId');
      print('Full response: ${value.data}');
      if (value.data is Map<String, dynamic>) {
        stuAllModel = StuAllModel.fromJson(value.data);
        print("Course title: ${stuAllModel?.stCourses![0].title.toString()}");
        emit(StudentCoursesSuccessState(stuAllModel));
      } else {
        print('Error occurred: value.data is not a Map<String, dynamic>');
        emit(StudentCoursesErrorState());
      }

      print("Course title: ${stuAllModel?.stCourses![0].title.toString()}");
      emit(StudentCoursesSuccessState(stuAllModel));
    }).catchError((error) {
      print('Error occurred: $error');
      emit(StudentCoursesErrorState());
    });
  }

  CoursesLectureModel? coursesLectureModel;
  getCourseLectures() {

    emit(GetCourseLecturesLoadingState());
print("sxscscscscsccscscs");
    DioHelper.getData(
        "https://omar-gradeuation-project.forloop-eg.com/api/doctor/course/$LectureId/lectures",
                query: {
          'status': true,
        }, token: userToken
    ).then((value) {
      print('$LectureId');
      print('Full response: ${value.data}');
      if (value.data is Map<String, dynamic>) {
        coursesLectureModel = CoursesLectureModel.fromJson(value.data);
        print("Course title: ${coursesLectureModel?.courses![0].title.toString()}");
        emit(GetCourseLecturesSuccessState(coursesLectureModel));
      } else {
        print('Error occurred: value.data is not a Map<String, dynamic>');
        emit(GetCourseLecturesErrorState());
      }

      print("Course title: ${coursesLectureModel?.courses![0].title.toString()}");
      emit(GetCourseLecturesSuccessState(coursesLectureModel));
    }).catchError((error) {
      print('Error occurred: $error');
      emit(GetDoctorCourseErrorState());
    });
  }

  DoctorAttendanceModel? doctorAttendanceModel;
  getDoctorAttendance() {

    emit(DoctorAttendanceLoadingState());
print("sxscscscscsccscscs");
    DioHelper.getData(
        "https://omar-gradeuation-project.forloop-eg.com/api/doctor/lectures/$AttendanceId/attendance",
                query: {
          'status': true,
        }, token: doctorToken
    ).then((value) {
      print('$AttendanceId');
      print('Full response: ${value.data}');
      if (value.data is Map<String, dynamic>) {
        doctorAttendanceModel = DoctorAttendanceModel.fromJson(value.data);
        print("Course title: ${doctorAttendanceModel?.students![0].name}");
        emit(DoctorAttendanceSuccessState(doctorAttendanceModel));
      } else {
        print('Error occurred: value.data is not a Map<String, dynamic>');
        emit(DoctorAttendanceErrorState());
      }

      print("Course title: ${doctorAttendanceModel?.students![0].name.toString()}");
      emit(DoctorAttendanceSuccessState(doctorAttendanceModel));
    }).catchError((error) {
      print('Error occurred: $error');
      emit(DoctorAttendanceErrorState());
    });
  }




  StudentAttendanceModel? studentAttendanceModel;
  getStudentAttendance() {

    emit(DoctorAttendanceLoadingState());
print("sxscscscscsccscscs");
    DioHelper.getData(
        "https://omar-gradeuation-project.forloop-eg.com/api/doctor/lectures/$AttendanceId/attendance",
                query: {
          'status': true,
        }, token: doctorToken
    ).then((value) {
      print('$AttendanceId');
      print('Full response: ${value.data}');
      if (value.data is Map<String, dynamic>) {
        doctorAttendanceModel = DoctorAttendanceModel.fromJson(value.data);
        print("Course title: ${doctorAttendanceModel?.students![0].name}");
        emit(DoctorAttendanceSuccessState(doctorAttendanceModel));
      } else {
        print('Error occurred: value.data is not a Map<String, dynamic>');
        emit(DoctorAttendanceErrorState());
      }

      print("Course title: ${doctorAttendanceModel?.students![0].name.toString()}");
      emit(DoctorAttendanceSuccessState(doctorAttendanceModel));
    }).catchError((error) {
      print('Error occurred: $error');
      emit(DoctorAttendanceErrorState());
    });
  }

}
