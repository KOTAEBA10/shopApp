
import '../../../models/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates {}

class RegisterChangeIconState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}
