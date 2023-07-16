import 'package:attendencesystem/Cubit/cubit.dart';
import 'package:attendencesystem/Cubit/states.dart';
import 'package:attendencesystem/Screens/allCourses/allCourses.dart';
import 'package:attendencesystem/Screens/lectures/user_Lecture_Details.dart';
import 'package:attendencesystem/model/doctor_get_courses.dart';
import 'package:attendencesystem/model/student_all_model.dart';
import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:attendencesystem/studentModel/studentallCourses.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentHome extends StatelessWidget {
  StudentHome({Key? key}) : super(key: key);
  var fixedHieght;
  var fixedWidth;

  @override
  Widget build(BuildContext context) {
    fixedHieght = MediaQuery.of(context).size.height;
    fixedWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Name'),
        centerTitle: true,
        backgroundColor: kPrimarycolor,
      ),
      body: BlocProvider(
        create: (BuildContext context) => AppCubit()..getStudentAllCourse(),
        child: BlocConsumer<AppCubit, AppStates>(
          builder: (BuildContext context, state) {
            var cubit = context.watch<AppCubit>();
// Fetch the instance of the AppCubit
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(fixedHieght * 8.0 / fixedHieght),
                child: Column(
                  children: [
                    SizedBox(
                      height: 17,
                    ),
                    Container(
                      height: fixedHieght * 700 / fixedHieght,
                      child: ConditionalBuilder(
                        condition: state is! StudentAllLoadingState,
                        builder: (context) => ListView.builder(
                          itemBuilder: (context, int index) {
                            if (cubit.studentAllCoursesModel != null) {
                              return InkWell(
                                onTap: () {
                                  UserAttendantId = cubit.studentAllCoursesModel?.courses![index].id;
                                  print('$UserAttendantId');
                                  print('$UserAttendantId');

                                  if (cubit.studentAllCoursesModel != null &&
                                      cubit.studentAllCoursesModel!.courses != null &&
                                      cubit.studentAllCoursesModel!.courses!.isNotEmpty) {
                                    cubit.getStudentCourse(UserAttendantId!); // Here

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CourseDetailScreen(courses: cubit.studentAllCoursesModel!.courses![index],),
                                      ),
                                    );
                                  }
                                  cubit.getStudentCourse(UserAttendantId!); // And here
                                  print('Length of courses: ${cubit.studentAllCoursesModel?.courses!.length}');
                                },
                                child: LectureCard1(
                                  model: cubit.studentAllCoursesModel?.courses![index],
                                  fixedHieght: fixedHieght,
                                  fixedWidth: fixedWidth,
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                          itemCount: cubit.studentAllCoursesModel?.courses!.length,
                        ),
                        fallback: (BuildContext context) {
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (BuildContext context, Object? state) {},
        ),
      ),
    );
  }
}

Widget LectureCard1({
  Courses2? model,
  required var fixedHieght,
  required var fixedWidth,
}) =>
    Column(
      children: [
        Container(
          height: fixedHieght * 80 / fixedHieght,
          child: Container(
            margin: EdgeInsets.only(
                right: fixedHieght * 5 / fixedHieght,
                left: fixedHieght * 5 / fixedHieght),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Id:${model?.id}",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  width: fixedWidth * 64 / fixedWidth,
                  height: fixedHieght * 63 / fixedHieght,
                  decoration: BoxDecoration(
                      color: Color(0xff0277BD).withOpacity(.6),
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: fixedHieght * 10 / fixedHieght,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${model?.title.toString()}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            "${model?.title.toString()}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xff4CE3B2).withOpacity(.3),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
