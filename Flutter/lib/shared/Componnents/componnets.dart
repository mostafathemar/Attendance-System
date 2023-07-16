import 'package:attendencesystem/model/doctor_get_courses.dart';
import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:flutter/material.dart';
Widget defaultFormField({
  required Widget label,
  var border = const OutlineInputBorder(),
  required IconData prefix,
  IconData? suffix,
  required TextEditingController controller,
  required var validate,
  required TextInputType type,
  var onSubmitted,
  var onIconPressed,
  Color textColor = Colors.black,
  bool obscuredText = false
}) => TextFormField(
  decoration: InputDecoration(
    label: label,
    border: border,
    prefixIcon:Icon(
      prefix,
    ),
    suffixIcon: IconButton(
      icon: Icon(
        suffix,
      ),
      onPressed:onIconPressed ,
    ),

  ),
  keyboardType: type,
  controller: controller,
  onFieldSubmitted: onSubmitted,
  obscureText: obscuredText,
  style: TextStyle(
      color: textColor
  ),
  validator: validate,

);
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) => false);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
Widget HospitalCard()=>Card(
  elevation: 2,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Container(
      color: kSeconderycolor,
      height: 80,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Al Ahrar Hospital',),
            SizedBox(height: 7,),
            Text('Emergency: Tus,Wen',),

            SizedBox(height: 7,),
            Text('500m',style: TextStyle(color: Colors.grey),)

          ],
        ),
      ),
    ),
  ),
);
Widget DoctorsCard()=> Card(
  elevation: 2,
  color: kSeconderycolor,
  child:Row(


    children: [
      Container(width: 60,
        height: 60,
        child: Icon(Icons.person,fill: 1,),
      ),
      SizedBox(width: 10,),
      Column(children: [
        Text('Dr: Ahmed ali '),
        SizedBox(height: 2,),
        Text('Work time:  9 :6'),
        SizedBox(height: 2,),
        Text('vacations:  fri, sat',style: TextStyle(color: Colors.grey),),


      ],)

    ],),
);
Widget ReservationCard()=> Card(
  elevation: 2,
  color: kSeconderycolor,
  child: Padding(
    padding: const EdgeInsets.only(right: 8.0,left: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,
          height: 60,
          child: Icon(
            Icons.person,
            fill: 1,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: Ahmed Khaled '),
            SizedBox(
              height: 2,
            ),
            Text(
              'reservation day: Sunday',

            ),
            SizedBox(
              height: 2,
            ),
            Text('Reservation time: 11.00 am', style: TextStyle(color: Colors.grey),),

          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(onTap: (){},child: Icon(Icons.add,weight: 100,)),
                  Text("Add Med",style: TextStyle(fontSize: 10,color: Colors.grey),)
                ],
              ),
            ),
            SizedBox(height: 1,),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(onTap: (){},child: Icon(Icons.info)),
                  Text("More Info",style: TextStyle(fontSize: 10,color: Colors.grey),)
                ],
              ),
            ),

          ],
        ),
      ],
    ),
  ),
);
Widget LectureCard({
  Courses? model,
  required var fixedHieght,
  required  var fixedWidth,
  required String? lecname,
  required String? date,
  required  String? attendancenumber,
})=>
    Column(
      children: [
        Container(
          height: fixedHieght*80/fixedHieght,
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
                        attendancenumber!,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Text(
                        "${model?.id}",
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
                            model!.title!,
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
                            date!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color:Colors.black ),
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

        SizedBox(height: 10,)
      ],
    );
