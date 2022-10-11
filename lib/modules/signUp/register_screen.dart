import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:help/layout/app_layout.dart';
import 'package:help/modules/login/login_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';
import '../../shared/components/components.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var FormKey=GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          if(state is CreateUserSuccessState)
          {
            // StreamBuilder<User?>(
            //   stream:  FirebaseAuth.instance.authStateChanges(),
            //   builder: (context,snapshot)
            //   {
            //     if(snapshot.hasData)
            //     {
            //       return VerifyEmailPage();
            //     }
            //   },
            // );
            navigateAndFinish(context, LoginScreen());
          }
          // if (state is RegisterCreateUserSuccessStates) {
          //   CacheHelper.saveData(key: 'id', value: state.id).then((value) {
          //     id = CacheHelper.getData(key: 'id');
          //     HireCubit.get(context).getUserData().then((value) {
          //       navigateAndFinish(context, CompleteLayout());
          //     });
          //   }).catchError((error) {});
          // }
          if(state is RegisterErrorState)
          {
            showToast(text: state.error.toString(), state: toastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(3.h)),
                child: Column(
                  children: [

                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(2.5.h),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: SingleChildScrollView(
                            child: Form(
                              key: FormKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Text(' now to get job offer',
                                      //     style: TextStyle(fontSize: 22)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  defaultTextFormField(
                                      validator: (value)
                                      {
                                        if(value!.isEmpty)
                                        {
                                          return 'Please enter your name';
                                        }
                                        return null ;
                                      },
                                      controller: nameController,
                                      type: TextInputType.text,
                                      label: 'Full Name',
                                      prefix: Icons.person),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  defaultTextFormField(
                                      validator: (value)
                                      {
                                        //bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                                        if(value!.isEmpty)
                                        {
                                          return 'Please enter your email address';
                                        }else if(EmailValidator.validate(value) == false)
                                        {
                                          return 'Please enter a valid email';
                                        }
                                        return null ;
                                      },
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      label: 'Email Address',
                                      prefix: Icons.email),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  ///////////////////////////////////////////////////////////
                                  IntlPhoneField(
                                    controller:phoneController ,
                                    keyboardType: TextInputType.phone,
                                    cursorColor: Colors.black,
                                    textAlignVertical: TextAlignVertical.center,
                                    initialCountryCode: 'EG',
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                    ),

                                    onChanged: (phone)
                                    {
                                      print(phone.completeNumber);
                                      cubit.setPhoneController(phone);
                                    },
                                    onCountryChanged: (country) {
                                      print('Country changed to: ' + country.name);
                                    },
                                  ),

                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  defaultTextFormField(
                                      validator: (value)
                                      {
                                        if(value!.isEmpty)
                                        {
                                          return 'Please enter your password';
                                        }
                                        else if (cubit.isSuccess == false)
                                        {
                                          return 'Please follow password criteria';
                                        }
                                        return null ;
                                      },
                                      controller: passwordController,
                                      type: TextInputType.visiblePassword,
                                      label: 'password',
                                      prefix: Icons.lock,
                                      suffix: cubit.suffix,
                                      isPassword: cubit.isPassword,
                                      suffixPressed: ()
                                      {
                                        cubit.changePasswordVisibility();
                                      }
                                      ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  FlutterPwValidator(
                                    controller: passwordController,
                                    width: 400,
                                    height: 150,
                                    minLength: 8,
                                    numericCharCount: 1,
                                    normalCharCount: 1,
                                    onSuccess: ()
                                    {
                                      cubit.getPasswordState();
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('password is matched')));
                                    },

                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  defaultButton(
                                      callback: ()
                                      {
                                        if(FormKey.currentState != null && FormKey.currentState!.validate())
                                                {
                                                  cubit.userRegister(
                                                      name: nameController.text,
                                                      email: emailController.text,
                                                      phone: cubit.myPhone,
                                                      password: passwordController.text);
                                                }

                                      },
                                      text:'Sign up'  ) ,




                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}