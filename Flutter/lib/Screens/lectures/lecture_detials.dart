import 'package:attendencesystem/Cubit/states.dart';
import 'package:attendencesystem/Screens/lectures/lecture_detials.dart';
import 'package:attendencesystem/model/CoursesLecture.dart';
import 'package:attendencesystem/model/doctor_attendace_model.dart';
import 'package:attendencesystem/model/doctor_get_courses.dart';
import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/cubit.dart';

class Lecture_Detials extends StatefulWidget {
  final Courses2 coursede;

  Lecture_Detials({Key? key, required this.coursede }) : super(key: key,);

  @override
  _Lecture_DetialsState createState() => _Lecture_DetialsState(coursede);
}

class _Lecture_DetialsState extends State<Lecture_Detials> {
  var fixedHieght;
  var fixedWidth;

  _Lecture_DetialsState(this.coursede);

  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().getDoctorAttendance();
  }

  final Courses2 coursede;

  @override
  Widget build(BuildContext context) {
    fixedHieght = MediaQuery.of(context).size.height;
    fixedWidth = MediaQuery.of(context).size.width;
    return  Scaffold(

      appBar: AppBar(title: Text('${coursede.title}'),centerTitle: true,backgroundColor: kPrimarycolor,),
      body: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) {
          var cubit = context.watch<AppCubit>(); // Fetch the instance of the AppCubit

          if (cubit.doctorAttendanceModel == null ||
              cubit.doctorAttendanceModel!.students == null ||
              cubit.doctorAttendanceModel!.students!.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return  Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ListView.builder(

                  itemBuilder: (context, index) => buildStudentAttendance(cubit.doctorAttendanceModel?.students![index]),
                  itemCount: cubit.doctorAttendanceModel?.students!.length
                  ,
                ),
              ),
            );
          }
        },
        listener: (BuildContext context, Object? state) {},
      ),

    );
  }
}
Column buildStudentAttendance(
    Students? model
    ) {
  Color? attC;
  return Column(
    children: [
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.done_all,
            color: model?.attended==false? attC=Colors.black:attC=Colors.blue,
          ),
          Text(
            '${model?.name}',
            style:
            TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ],
  );
}
