

import '../../../model/register_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterDataSuccessState extends RegisterStates{
  RegisterModel registerModel;
  RegisterDataSuccessState(this.registerModel);

}

class RegisterDataErrorState extends RegisterStates{}

class RegisterDataLoadingState extends RegisterStates{}

class SuffixVisibilityRegisterState extends RegisterStates{}