import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:help/layout/app_layout.dart';
import 'package:help/modules/login/wlcome_screen.dart';
import 'package:help/shared/components/components.dart';
import 'package:help/shared/styles/icon_broken.dart';

import '../../shared/components/constants.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified=false;
  bool canResendEmail = false;
  Timer? timer;



  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified){
      sendVerificationEmail();
      
      timer = Timer.periodic(
          Duration(seconds: 3),
              (_) => checkEmailVerified());
    }
  }

  void dispose(){
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified()async
  {
    await FirebaseAuth.instance.currentUser!.reload();
    setState((){
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    });

    if(isEmailVerified) {
      timer?.cancel();
      await FirebaseFirestore.instance.collection("users")
          .doc(uId)
          .update({
        'isEmailVerified' : true
      });
    }
  }

  Future sendVerificationEmail()async
  {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() =>canResendEmail = false);
      await Future.delayed(Duration(seconds: 10));
      setState(() =>canResendEmail = true);
    }catch (e){
      showToast(text: e.toString(), state: toastStates.ERROR);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ?AppLayoutScreen()
      : Scaffold(
    appBar: AppBar(
      title: const Text('Verify Email'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Text(
            'A verification email has been sent to your email .',
            style: TextStyle( fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 24,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50)
            ),
              icon: Icon(IconBroken.Message,size: 32),
              label: Text(
                'Resend Email',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              onPressed:()
              {
                if (canResendEmail) sendVerificationEmail();
              } ,
          ),
          SizedBox(height: 8,),
          TextButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50)
            ),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 24),
              ),
            onPressed: ()
            {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    ),
  );}
