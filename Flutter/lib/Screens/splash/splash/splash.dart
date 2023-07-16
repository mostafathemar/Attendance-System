
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../../Auth/userlogin/logIn/login.dart';
class Splash_Animated extends StatelessWidget {
  const Splash_Animated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: AnimatedSplashScreen(
            splashIconSize: double.infinity,
            backgroundColor: Color(0xff2CAFFE).withOpacity(.1),
            splash:  Container(
              width: double.infinity,
             child: Image.asset('assets/images/attendanceLogo.png',fit: BoxFit.fill,),
            ),
            nextScreen:  LogInPage(),

// we can use
            duration: 2000,
//5000= 5 Second

//control the duration of the image , we can use
            animationDuration: const Duration(seconds: 3)),
      ),
    );
//small number : the duration will be speed
//large number : the duratiion will be slow);
  }
}