
abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

///change password visibility
class ChangePasswordVisibilityState extends LoginStates{}
///////////////////////////////////////////////////
///user login
class UserLoginLoadingState extends LoginStates{}
class UserLoginSuccessState extends LoginStates
{
  final String uId;
  UserLoginSuccessState(this.uId);
}
class UserLoginErrorState extends LoginStates
{
  final String error;
  UserLoginErrorState(this.error);
}
////////////////////////////////////////////////////


