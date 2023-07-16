import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatelessWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSeconderycolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/images/person1.png',height: 100,),
          SizedBox(height: 30,),
          TextButton(
              onPressed: () {},
              child: Text(
                "Upload Photo",
                style: TextStyle(color: kPrimarycolor, fontSize: 25),
              )


          ),
          Align(
            alignment: Alignment.center,
              child: Text('with your phone',style: TextStyle(color: Colors.grey),)),
          SizedBox(height: 40,),
          TextButton(
              onPressed: () {
                ImagePicker();
              },
              child: Text(
                "Take Photo",
                style: TextStyle(color: kPrimarycolor, fontSize: 25),
              )


          ),
          Align(
              alignment: Alignment.center,
              child: Text('with your phone',style: TextStyle(color: Colors.grey),)),
        ],
      ),
    );
  }
}
