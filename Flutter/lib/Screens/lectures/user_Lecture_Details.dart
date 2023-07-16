import 'package:attendencesystem/Cubit/cubit.dart';
import 'package:attendencesystem/Cubit/states.dart';
import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:attendencesystem/studentModel/studentallCourses.dart';
import 'package:flutter/material.dart';
import 'package:attendencesystem/model/student_all_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CourseDetailScreen extends StatefulWidget {
  final Courses2 courses;

  CourseDetailScreen({Key? key,required this.courses }) : super(key: key,);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState(courses);
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  var fixedHieght;
  var fixedWidth;

  _CourseDetailScreenState(this.courses);

  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().getStudentCourse(UserAttendantId!);
  }
  final Courses2 courses;

  @override
  Widget build(BuildContext context) {
    fixedHieght = MediaQuery.of(context).size.height;
    fixedWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('${courses.title}'),
      ),
      body: BlocConsumer<AppCubit,AppStates>(
        builder: (BuildContext context, state) {
          var cubit = context.watch<AppCubit>(); // Fetch the instance of the AppCubit
            AppCubit().getStudentCourse(UserAttendantId!);
          if (cubit.stuAllModel == null ) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              height: fixedHieght * 1000 / fixedHieght,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {

                    },
                    child: buildCoursesLectures(
                        model: cubit.stuAllModel?.stCourses![index], fixedHieght: fixedHieght),
                  );
                },
                itemCount: cubit.stuAllModel?.stCourses!.length,
              ),
            );
          }
        },
        listener: (BuildContext context, Object? state) {  },

      ),
    );
  }
}
Padding buildCoursesLectures({StCourses? model,  required fixedHieght
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