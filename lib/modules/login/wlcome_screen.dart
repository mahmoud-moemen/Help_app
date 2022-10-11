import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:help/modules/login/login_screen.dart';
import 'package:help/modules/signUp/register_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../../shared/components/components.dart';

class WelcomeScreen extends StatelessWidget {
   WelcomeScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Container(
                height: 150,
                alignment: AlignmentDirectional.center,
                child: const Image(image: AssetImage('assets/images/help logo.png'),fit: BoxFit.cover, )),
            Expanded(
              child: Container(
                width : double.infinity,
                decoration: BoxDecoration(
                  // color: HexColor('#869ea0'),
                  //color: Colors.grey,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(60),
                  //   topRight: Radius.circular(60),),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>
                    [
                      SignInButton(
                        Buttons.Google,
                        onPressed: (){},
                      ),
                      Divider(),
                      SignInButton(
                          Buttons.Facebook,
                          onPressed: (){}),
                      Divider(),
                      SignInButtonBuilder(
                        text: 'Get going with Email',
                        icon: Icons.email,
                        backgroundColor: Colors.blueGrey[700]!,
                        width: 300.0,
                        height: 50,
                        onPressed: ()
                        {
                          navigateTo(context, RegisterScreen());
                        }

                      ),
                      Divider(),
                      const Text('Already have an account ?',
                          style: TextStyle(fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: ()
                        {
                          navigateTo(context, LoginScreen());
                        },
                        height: 50,
                        minWidth: 200,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          color: Colors.blueGrey[700]!,
                        child: Text(
                          'Login'
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}


///show modal bottom sheet
// showModalBottomSheet(
// isScrollControlled: true,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(20.0),
// topRight:Radius.circular(20.0),
// )
// ),
// backgroundColor: Colors.transparent,
// context: context,
// builder: (context) => buildSignUpSheet(),
// )

///bottom sheet container
// Widget buildSignUpSheet() =>DraggableScrollableSheet(
//   initialChildSize: 0.7,
//   maxChildSize: 0.7,
//
//
//   builder: (_,controller) => Container(
//     decoration: BoxDecoration(
//         color: Colors.white,
//         //borderRadius: BorderRadiusDirectional.circular(3.h)
//     ),
//     child: ListView(
//       //mainAxisSize: MainAxisSize.min,
//       controller:controller ,
//       children: [
//         SizedBox(
//           height: 3.h,
//         ),
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadiusDirectional.circular(2.5.h),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(2.h),
//             child: SingleChildScrollView(
//               child: Form(
//
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     defaultTextFormField(
//                         validator: (value)
//                         {
//                           if(value!.isEmpty)
//                           {
//                             return 'Please enter your name';
//                           }
//                           return null ;
//                         },
//                         controller: nameController,
//                         type: TextInputType.text,
//                         label: 'Full Name',
//                         prefix: Icons.person),
//                     SizedBox(
//                       height: 1.h,
//                     ),
//                     defaultTextFormField(
//                         validator: (value)
//                         {
//                           // //bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
//                           // if(value!.isEmpty)
//                           // {
//                           //   return 'Please enter your email address';
//                           // }else if(EmailValidator.validate(value) == false)
//                           // {
//                           //   return 'Please enter a valid email';
//                           // }
//                           // return null ;
//                         },
//                         controller: emailController,
//                         type: TextInputType.emailAddress,
//                         label: 'Email Address',
//                         prefix: Icons.email),
//                     SizedBox(
//                       height: 1.h,
//                     ),
//                     ///////////////////////////////////////////////////////////
//                     IntlPhoneField(
//                       controller:phoneController ,
//                       keyboardType: TextInputType.phone,
//                       cursorColor: Colors.black,
//                       textAlignVertical: TextAlignVertical.center,
//                       initialCountryCode: 'EG',
//                       decoration: InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(),
//                         ),
//                       ),
//
//                       onChanged: (phone){
//                         // print(phone.completeNumber);
//                         // cubit.setPhoneController(phone);
//                       },
//                       onCountryChanged: (country) {
//                         print('Country changed to: ' + country.name);
//                       },
//                     ),
//
//                     SizedBox(
//                       height: 1.h,
//                     ),
//                     defaultTextFormField(
//                         validator: (value)
//                         {
//                           if(value!.isEmpty)
//                           {
//                             return 'Please enter your password';
//                           }
//                           // else if (cubit.isSuccess == false)
//                               {
//                             return 'Please follow password criteria';
//                           }
//                           return null ;
//                         },
//                         controller: passwordController,
//                         type: TextInputType.visiblePassword,
//                         label: 'password',
//                         prefix: Icons.lock,
//                         // suffix: cubit.icon,
//                         // isPassword: cubit.showPassword,
//                         // showPassword: () {
//                         //   // cubit.changePassword();
//                         // }
//                         ),
//                     SizedBox(
//                       height: 5,
//                     ),
//
//                     FlutterPwValidator(
//                       controller: passwordController,
//                       width: 400,
//                       height: 150,
//                       minLength: 8,
//                       numericCharCount: 1,
//                       normalCharCount: 1,
//                       onSuccess: ()
//                       {
//                         // cubit.getPasswordState();
//                         // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('password is matched')));
//                       },
//
//                     ),
//                     SizedBox(
//                       height: 3.h,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           color: const Color(0xFF1A6BB7),
//                           borderRadius:
//                           BorderRadiusDirectional.circular(1.h)),
//                       child: Padding(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 1.h),
//                         child: MaterialButton(
//                           onPressed: ()
//                           {
//                             // if(FormKey.currentState != null && FormKey.currentState!.validate())
//                             // {
//                             //   cubit.userRegister(
//                             //       name: nameController.text,
//                             //       email: emailController.text,
//                             //       phone: cubit.myPhone,
//                             //       password: passwordController.text);
//                             //}
//
//                           },
//                           child: Text(
//                             'Sign up',
//                             style: TextStyle(
//                                 color: Colors.white, fontSize: 20),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );
// Widget buildLogInSheet(BuildContext context) =>DraggableScrollableSheet(
//   initialChildSize: 0.7,
//   maxChildSize: 0.7,
//
//
//   builder: (_,controller) => Container(
//     decoration: BoxDecoration(
//         color: Colors.white,
//         //borderRadius: BorderRadiusDirectional.circular(3.h)
//     ),
//     child: ListView(
//       //mainAxisSize: MainAxisSize.min,
//       controller:controller ,
//       children: [
//         SizedBox(
//           height: 3.h,
//         ),
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadiusDirectional.circular(2.5.h),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(2.h),
//             child: SingleChildScrollView(
//               child: Form(
//
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'LOGIN',
//                       style:Theme.of(context).textTheme.headline4?.copyWith(
//                         color: Colors.black
//                       ),
//                       ),
//
//                     Text(
//                       'Login Now To Get Your Answer',
//                       style:Theme.of(context).textTheme.bodyText1?.copyWith(
//                         color: Colors.grey,
//                       ),
//                     ),SizedBox(
//                       height: 3.h,
//                     ),
//                     defaultTextFormField(
//                         controller: passwordController,
//                         onSubmitted: (value)
//                         {
//                           if (formKey.currentState != null && formKey.currentState!.validate())
//                           {
//
//                             // LoginCubit.get(context).userLogin(
//                             // email: emailController.text,
//                             // password:passwordController.text );
//                           }
//                         },
//                         type: TextInputType.visiblePassword,
//                         validator: (value)
//                         {
//                           if(value!.isEmpty)
//                           {
//                             return 'please enter your password';
//                           }
//                           return null;
//
//
//                         },
//                         label: 'Password',
//                         prefix:Icons.lock_clock_outlined,
//                         isPassword:LoginCubit.get(context).isPassword,
//                         suffix:LoginCubit.get(context).suffix ,
//                         suffixPressed: ()
//                         {
//                           LoginCubit.get(context).changePasswordVisibility();
//                         }),
//                     SizedBox(
//                       height: 1.h,
//                     ),
//                     defaultTextFormField(
//                         controller: passwordController,
//                         onSubmitted: (value)
//                         {
//                           if (formKey.currentState != null && formKey.currentState!.validate())
//                           {
//
//                             // LoginCubit.get(context).userLogin(
//                             // email: emailController.text,
//                             // password:passwordController.text );
//                           }
//                         },
//                         type: TextInputType.visiblePassword,
//                         validator: (value)
//                         {
//                           if(value!.isEmpty)
//                           {
//                             return 'please enter your password';
//                           }
//                           return null;
//
//
//                         },
//                         label: 'Password',
//                         prefix:Icons.lock_clock_outlined,
//                         isPassword:LoginCubit.get(context).isPassword,
//                         suffix:LoginCubit.get(context).suffix ,
//                         suffixPressed: ()
//                         {
//                           LoginCubit.get(context).changePasswordVisibility();
//                         }),
//                     SizedBox(
//                       height: 1.h,
//                     ),
//                     ///////////////////////////////////////////////////////////
//                     IntlPhoneField(
//                       controller:phoneController ,
//                       keyboardType: TextInputType.phone,
//                       cursorColor: Colors.black,
//                       textAlignVertical: TextAlignVertical.center,
//                       initialCountryCode: 'EG',
//                       decoration: InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(),
//                         ),
//                       ),
//
//                       onChanged: (phone){
//                         // print(phone.completeNumber);
//                         // cubit.setPhoneController(phone);
//                       },
//                       onCountryChanged: (country) {
//                         print('Country changed to: ' + country.name);
//                       },
//                     ),
//
//                     SizedBox(
//                       height: 1.h,
//                     ),
//                     defaultTextFormField(
//                         validator: (value)
//                         {
//                           if(value!.isEmpty)
//                           {
//                             return 'Please enter your password';
//                           }
//                           // else if (cubit.isSuccess == false)
//                               {
//                             return 'Please follow password criteria';
//                           }
//                           return null ;
//                         },
//                         controller: passwordController,
//                         type: TextInputType.visiblePassword,
//                         label: 'password',
//                         prefix: Icons.lock,
//                         // suffix: cubit.icon,
//                         // isPassword: cubit.showPassword,
//                         showPassword: () {
//                           // cubit.changePassword();
//                         }),
//                     SizedBox(
//                       height: 5,
//                     ),
//
//                     FlutterPwValidator(
//                       controller: passwordController,
//                       width: 400,
//                       height: 150,
//                       minLength: 8,
//                       numericCharCount: 1,
//                       normalCharCount: 1,
//                       onSuccess: ()
//                       {
//                         // cubit.getPasswordState();
//                         // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('password is matched')));
//                       },
//
//                     ),
//                     SizedBox(
//                       height: 3.h,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           color: const Color(0xFF1A6BB7),
//                           borderRadius:
//                           BorderRadiusDirectional.circular(1.h)),
//                       child: Padding(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 1.h),
//                         child: MaterialButton(
//                           onPressed: ()
//                           {
//                             // if(FormKey.currentState != null && FormKey.currentState!.validate())
//                             // {
//                             //   cubit.userRegister(
//                             //       name: nameController.text,
//                             //       email: emailController.text,
//                             //       phone: cubit.myPhone,
//                             //       password: passwordController.text);
//                             //}
//
//                           },
//                           child: Text(
//                             'Sign up',
//                             style: TextStyle(
//                                 color: Colors.white, fontSize: 20),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );


