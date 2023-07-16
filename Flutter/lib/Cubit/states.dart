
import 'package:attendencesystem/model/CoursesLecture.dart';
import 'package:attendencesystem/model/doctor_attendace_model.dart';
import 'package:attendencesystem/model/doctor_get_courses.dart';
import 'package:attendencesystem/model/student_all_model.dart';
import 'package:attendencesystem/model/student_attendance.dart';
import 'package:attendencesystem/studentModel/studentallCourses.dart';

abstract class AppStates{}
class AppInitialState extends AppStates{}
class ChangeBottomNav extends AppStates{}
class ChangeDoctorDataNav extends AppStates{}

class GetDoctorCourseLoadingState extends AppStates{}
class GetDoctorCourseSuccessState extends AppStates{
   GetDoctorCourseModel? getDoctorCourseModel;

  GetDoctorCourseSuccessState(this.getDoctorCourseModel);
}
class GetDoctorCourseErrorState extends AppStates{}

class GetCourseLecturesLoadingState extends AppStates{}
class GetCourseLecturesSuccessState extends AppStates{
  CoursesLectureModel? coursesLectureModel;

   GetCourseLecturesSuccessState(this.coursesLectureModel);
}
class GetCourseLecturesErrorState extends AppStates{}

class DoctorAttendanceLoadingState extends AppStates{}
class DoctorAttendanceSuccessState extends AppStates{
  DoctorAttendanceModel? doctorAttendanceModel;

  DoctorAttendanceSuccessState(this.doctorAttendanceModel);
}
class DoctorAttendanceErrorState extends AppStates{}


class StudentAttendanceLoadingState extends AppStates{}
class StudentAttendanceSuccessState extends AppStates{
  StudentAttendanceModel? studentAttendanceModel;

  StudentAttendanceSuccessState(this.studentAttendanceModel);
}
class StudentAttendanceErrorState extends AppStates{}

class StudentAllLoadingState extends AppStates{}
class StudentAllSuccessState extends AppStates{
  StudentAllCoursesModel? studentAllCoursesModel;

  StudentAllSuccessState(this.studentAllCoursesModel);
}
class StudentAllErrorState extends AppStates{}

class StudentCoursesLoadingState extends AppStates{}
class StudentCoursesSuccessState extends AppStates{
  StuAllModel? stuAllModel;

  StudentCoursesSuccessState(this.stuAllModel);
}
class StudentCoursesErrorState extends AppStates{}

class AppLoadingState extends AppStates{}
class AppSuccessState extends AppStates{

}
class AppErrorState extends AppStates{}

