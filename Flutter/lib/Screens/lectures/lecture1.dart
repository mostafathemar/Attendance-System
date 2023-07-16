import 'package:attendencesystem/main.dart';
import 'package:attendencesystem/shared/Componnents/componnets.dart';
import 'package:flutter/material.dart';

import '../../shared/Componnents/constants.dart';
class Lecture1 extends StatelessWidget {
   Lecture1({Key? key}) : super(key: key);
   int numberOfAttendees=30;
   int numberOfAbsnce=10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lecture 1'),centerTitle: true,backgroundColor: kPrimarycolor,),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 150,
                  color: kPrimarycolor,
                  width: double.infinity,
                  child:Container(
                    margin: EdgeInsets.only(left: 9,right: 9,top: 9,bottom: 9),

                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Numer of attendees ',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)
                                ,),
                              SizedBox(width: 14,),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(66),
                                  child: Container(
                                    width: 66,
                                    height: 66,
                                    color: Colors.black.withOpacity(.2),
                                    child: Center(child: Text('$numberOfAttendees', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)
                                  )),))
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                              },

                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 50,

                                    child: Center(child: Padding(
                                      padding: const EdgeInsets.only(right: 6.0,left: 6),
                                      child: Text('Attendance Names',style: TextStyle(fontSize: 13),),
                                    )),color: Colors.white,)

                              ),
                            )],)
                      ],
                    ),
                  ),

                ),
              ),
              SizedBox(height: 40,),
              ClipRRect(borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 150,
                  color: Colors.red,
                  width: double.infinity,
                  child:Container(
                    margin: EdgeInsets.only(left: 9,right: 9,top: 9,bottom: 9),

                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Numer of absence ',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)
                                ,),
                              SizedBox(width: 14,),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(66),
                                  child: Container(
                                    width: 66,
                                    height: 66,
                                    color: Colors.black.withOpacity(.2),
                                    child: Center(child: Text('$numberOfAbsnce', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)
                                    )),))
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                              },

                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    height: 50,

                                    child: Center(child: Padding(
                                      padding: const EdgeInsets.only(right: 6.0,left: 6),
                                      child: Text('Absence Names',style: TextStyle(fontSize: 13),),
                                    )),color: Colors.white,)

                              ),
                            )],)
                      ],
                    ),
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
