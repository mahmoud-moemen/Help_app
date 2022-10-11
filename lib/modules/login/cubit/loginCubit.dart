import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:help/modules/login/cubit/loginStates.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  //////////////////////////////////////////////////////////////////////////////
  ///change password visibility
  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;
  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix = isPassword?Icons.visibility_off_outlined: Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }
  //////////////////////////////////////////////////////////////////////////////

  void userLogin({
    required String email,
    required String password,
  })
  {


    emit(UserLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword
      (email: email, password: password)
        .then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      emit(UserLoginSuccessState(value.user!.uid));
    }).catchError((error)
    {
      emit(UserLoginErrorState(error.toString()));
    });
  }



  ///google sign in
  late FirebaseAuth _auth;
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential =
          await _auth.signInWithCredential(credential);

          // if you want to do specific task like storing information in firestore
          // only for new users using google sign in (since there are no two options
          // for google sign in and google sign up, only one as of now),
          // do the following:

          // if (userCredential.user != null) {
          //   if (userCredential.additionalUserInfo!.isNewUser) {}
          // }
        }
      }
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message!); // Displaying the error message
    }
  }

}