import 'package:attendencesystem/Cubit/states.dart';
import 'package:attendencesystem/Screens/lectures/lecture_detials.dart';
import 'package:attendencesystem/model/CoursesLecture.dart';
import 'package:attendencesystem/model/doctor_get_courses.dart';
import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/cubit.dart';

class AllCourses extends StatefulWidget {
  final Courses courses;

  AllCourses({Key? key,required this.courses }) : super(key: key,);

  @override
  _AllCoursesState createState() => _AllCoursesState(courses);
}

class _AllCoursesState extends State<AllCourses> {
  var fixedHieght;
  var fixedWidth;

  _AllCoursesState(this.courses);

  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().getCourseLectures();
  }
  final Courses courses;

  @override
  Widget build(BuildContext context) {
    fixedHieght = MediaQuery.of(context).size.height;
    fixedWidth = MediaQuery.of(context).size.width;

    return  Scaffold(

      appBar: AppBar(title: Text('${courses.title}'),centerTitle: true,
      backgroundColor: kPrimarycolor,
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) {
          var cubit = context.watch<AppCubit>(); // Fetch the instance of the AppCubit

          if (cubit.coursesLectureModel == null ||
              cubit.coursesLectureModel!.courses == null ||
              cubit.coursesLectureModel!.courses!.isEmpty||state is GetCourseLecturesLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          else {
            return Container(
              height: fixedHieght * 1000 / fixedHieght,
              child: ConditionalBuilder(
                condition: cubit.coursesLectureModel!.courses != null,
                builder: (BuildContext context) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          AttendanceId=cubit.coursesLectureModel?.courses![index].id;
                          print('$AttendanceId');
                          cubit.get(context).getDoctorAttendance();
                          Navigator.of(context).push(MaterialPageRoute(

                              builder: (context) => Lecture_Detials(
                                coursede: cubit.coursesLectureModel!.courses![index],
                              )));
                        },
                        child: buildCoursesLectures(
                            model: cubit.coursesLectureModel?.courses![index], fixedHieght: fixedHieght),
                      );
                    },
                    itemCount: cubit.coursesLectureModel?.courses!.length,
                  );
                },
                fallback: (BuildContext context) {
                  return Center(child: CircularProgressIndicator());
                },
              ),
            );
          }
        },
        listener: (BuildContext context, Object? state) {},
      ),

    );
  }
}
Padding buildCoursesLectures({Courses2? model,  required fixedHieght
})
{
  return Padding(
    padding:  EdgeInsets.all(fixedHieght*8.0/fixedHieght),
    child: Container (
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(fixedHieght*8.0/fixedHieght),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lecture Number: ${model?.title}"),
                    SizedBox(height: fixedHieght*7/fixedHieght,),
                    Text("Started At:${model?.startsAt}"),
                  ],),
                Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Date:${model?.date}"),
                    SizedBox(height: fixedHieght*7/fixedHieght,),

                    Text("Ended At:${model?.endsAt}"),
                  ],)

              ],),
          ),
          Divider(color: Colors.grey,)
        ],
      ),
    ),
  );
}
