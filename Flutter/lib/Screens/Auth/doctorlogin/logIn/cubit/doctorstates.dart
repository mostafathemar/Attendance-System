

import 'package:attendencesystem/model/Doctor_Login_Model.dart';

abstract class DoctorLoginStates{}

class DoctorLoginInitialState extends DoctorLoginStates{}

class DoctorLoginDataSuccessState extends DoctorLoginStates{
  final DoctorLogin doctorLogin;
  DoctorLoginDataSuccessState(this.doctorLogin);


}

class DoctorLoginDataErrorState extends DoctorLoginStates{}

class DoctorLoginDataLoadingState extends DoctorLoginStates{}

class DoctorSuffixVisibilityState extends DoctorLoginStates{}