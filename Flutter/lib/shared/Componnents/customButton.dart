import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.color, this.Ontap,required this.ButtonName,required this.condition});
  final String ButtonName;
  VoidCallback? Ontap;
  Color  color;
  bool  condition;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition:  condition ,
      builder: (context)=> Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color:color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: Ontap,

          child: Center(
              child: Text(
                ButtonName,
                style: TextStyle(color: kSeconderycolor),
              )),
        ),
      ),
      fallback:(context)=> Center(

          child: CircularProgressIndicator()),
    )
    ;
  }
}
