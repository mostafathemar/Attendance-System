import 'package:attendencesystem/Cubit/cubit.dart';
import 'package:attendencesystem/Screens/Auth/doctorlogin/logIn/cubit/doctorcubit.dart';
import 'package:attendencesystem/Screens/Auth/register/cubit/cubit.dart';
import 'package:attendencesystem/Screens/Auth/userlogin/logIn/cubit/UserCubit.dart';
import 'package:attendencesystem/Screens/splash/splash/splash.dart';
import 'package:attendencesystem/shared/Componnents/constants.dart';
import 'package:attendencesystem/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/Auth/userlogin/logIn/login.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  runApp(const MyApp());
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  userToken = CacheHelper.getData(key: 'api_token');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RegisterCubit()),
        BlocProvider(create: (_) => AppCubit()..getDoctorCourse()..getStudentCourse(UserAttendantId!)),
        BlocProvider(create: (_) => UserLoginCubit()),
        BlocProvider(create: (_) => DoctorLoginCubit()),
      ],
      child: const MaterialApp(

        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Splash_Animated();
  }
}

