// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';
//
//
// class FadeAnimation extends StatelessWidget {
//   final double delay;
//   final Widget child;
//
//   FadeAnimation(this.delay, this.child);
//
//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTrackTween([
//       Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
//       Track("translateY").add(
//           Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
//           curve: Curves.easeOut)
//     ]);
//
//     return ControlledAnimation(
//       delay: Duration(milliseconds: (500 * delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.translate(
//             offset: Offset(0, animation["translateY"]),
//             child: child
//         ),
//       ),
//     );
//   }
// }


////////////////////////////////////////////////////////////////////////////////
///
//profile page jonnason
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_pw_validator/flutter_pw_validator.dart';
// import 'package:flutter_signin_button/button_builder.dart';
// import 'package:flutter_signin_button/button_list.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../shared/components/components.dart';
//
// class LoginScreen extends StatelessWidget {
//   LoginScreen({Key? key}) : super(key: key);
//
//   var nameController = TextEditingController();
//   var emailController = TextEditingController();
//   var phoneController = TextEditingController();
//   var passwordController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         backwardsCompatibility: false,
//         systemOverlayStyle: SystemUiOverlayStyle(
//           statusBarColor: Colors.white,
//           statusBarBrightness: Brightness.light,
//           statusBarIconBrightness: Brightness.light,
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children:  [
//             Container(
//                 height: 150,
//                 alignment: AlignmentDirectional.center,
//                 child: const Image(image: AssetImage('assets/images/help logo.png'),fit: BoxFit.cover, )),
//             Expanded(
//               child: Container(
//                 width : double.infinity,
//                 decoration: BoxDecoration(
//                   // color: HexColor('#869ea0'),
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(60),
//                     topRight: Radius.circular(60),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(30),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>
//                     [
//                       SignInButton(
//                         Buttons.Google,
//                         onPressed: (){},
//                       ),
//                       Divider(),
//                       SignInButton(
//                           Buttons.Facebook,
//                           onPressed: (){}),
//                       Divider(),
//                       SignInButtonBuilder(
//                           text: 'Get going with Email',
//                           icon: Icons.email,
//                           backgroundColor: Colors.blueGrey[700]!,
//                           width: 300.0,
//                           height: 50,
//                           onPressed: () =>showModalBottomSheet(
//                             isScrollControlled: true,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20.0),
//                                   topRight:Radius.circular(20.0),
//                                 )
//                             ),
//                             backgroundColor: Colors.transparent,
//                             context: context,
//                             builder: (context) => buildSignUpSheet(),
//                           )
//                       ),
//                       Divider(),
//                       const Text('Already have an account ?',
//                         style: TextStyle(fontSize: 17),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       MaterialButton(
//                         onPressed: (){},
//                         height: 50,
//                         minWidth: 200,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
//                         color: Colors.blueGrey[700]!,
//                         child: Text(
//                             'Login'
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildSignUpSheet() =>DraggableScrollableSheet(
//     initialChildSize: 0.7,
//     maxChildSize: 0.7,
//
//
//     builder: (_,controller) => Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         //borderRadius: BorderRadiusDirectional.circular(3.h)
//       ),
//       child: ListView(
//         //mainAxisSize: MainAxisSize.min,
//         controller:controller ,
//         children: [
//           SizedBox(
//             height: 3.h,
//           ),
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadiusDirectional.circular(2.5.h),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(2.h),
//               child: SingleChildScrollView(
//                 child: Form(
//
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 2.h,
//                       ),
//                       defaultTextFormField(
//                           validator: (value)
//                           {
//                             if(value!.isEmpty)
//                             {
//                               return 'Please enter your name';
//                             }
//                             return null ;
//                           },
//                           controller: nameController,
//                           textInputType: TextInputType.text,
//                           label: 'Full Name',
//                           prefix: Icons.person),
//                       SizedBox(
//                         height: 1.h,
//                       ),
//                       defaultTextFormField(
//                           validator: (value)
//                           {
//                             // //bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
//                             // if(value!.isEmpty)
//                             // {
//                             //   return 'Please enter your email address';
//                             // }else if(EmailValidator.validate(value) == false)
//                             // {
//                             //   return 'Please enter a valid email';
//                             // }
//                             // return null ;
//                           },
//                           controller: emailController,
//                           textInputType: TextInputType.emailAddress,
//                           label: 'Email Address',
//                           prefix: Icons.email),
//                       SizedBox(
//                         height: 1.h,
//                       ),
//                       ///////////////////////////////////////////////////////////
//                       IntlPhoneField(
//                         controller:phoneController ,
//                         keyboardType: TextInputType.phone,
//                         cursorColor: Colors.black,
//                         textAlignVertical: TextAlignVertical.center,
//                         initialCountryCode: 'EG',
//                         decoration: InputDecoration(
//                           labelText: 'Phone Number',
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(),
//                           ),
//                         ),
//
//                         onChanged: (phone){
//                           // print(phone.completeNumber);
//                           // cubit.setPhoneController(phone);
//                         },
//                         onCountryChanged: (country) {
//                           print('Country changed to: ' + country.name);
//                         },
//                       ),
//
//                       SizedBox(
//                         height: 1.h,
//                       ),
//                       defaultTextFormField(
//                           validator: (value)
//                           {
//                             if(value!.isEmpty)
//                             {
//                               return 'Please enter your password';
//                             }
//                             // else if (cubit.isSuccess == false)
//                                 {
//                               return 'Please follow password criteria';
//                             }
//                             return null ;
//                           },
//                           controller: passwordController,
//                           textInputType: TextInputType.visiblePassword,
//                           label: 'password',
//                           prefix: Icons.lock,
//                           // suffix: cubit.icon,
//                           // isPassword: cubit.showPassword,
//                           showPassword: () {
//                             // cubit.changePassword();
//                           }),
//                       SizedBox(
//                         height: 5,
//                       ),
//
//                       FlutterPwValidator(
//                         controller: passwordController,
//                         width: 400,
//                         height: 150,
//                         minLength: 8,
//                         numericCharCount: 1,
//                         normalCharCount: 1,
//                         onSuccess: ()
//                         {
//                           // cubit.getPasswordState();
//                           // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('password is matched')));
//                         },
//
//                       ),
//                       SizedBox(
//                         height: 3.h,
//                       ),
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             color: const Color(0xFF1A6BB7),
//                             borderRadius:
//                             BorderRadiusDirectional.circular(1.h)),
//                         child: Padding(
//                           padding:
//                           EdgeInsets.symmetric(horizontal: 1.h),
//                           child: MaterialButton(
//                             onPressed: ()
//                             {
//                               // if(FormKey.currentState != null && FormKey.currentState!.validate())
//                               // {
//                               //   cubit.userRegister(
//                               //       name: nameController.text,
//                               //       email: emailController.text,
//                               //       phone: cubit.myPhone,
//                               //       password: passwordController.text);
//                               //}
//
//                             },
//                             child: Text(
//                               'Sign up',
//                               style: TextStyle(
//                                   color: Colors.white, fontSize: 20),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
//
// }
//

// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:user_profile_ii_example/model/user.dart';
// import 'package:user_profile_ii_example/page/edit_profile_page.dart';
// import 'package:user_profile_ii_example/utils/user_preferences.dart';
// import 'package:user_profile_ii_example/widget/appbar_widget.dart';
// import 'package:user_profile_ii_example/widget/button_widget.dart';
// import 'package:user_profile_ii_example/widget/numbers_widget.dart';
// import 'package:user_profile_ii_example/widget/profile_widget.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     final user = UserPreferences.myUser;
//
//     return ThemeSwitchingArea(
//       child: Builder(
//         builder: (context) => Scaffold(
//           appBar: buildAppBar(context),
//           body: ListView(
//             physics: BouncingScrollPhysics(),
//             children: [
//               ProfileWidget(
//                 imagePath: user.imagePath,
//                 onClicked: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => EditProfilePage()),
//                   );
//                 },
//               ),
//               const SizedBox(height: 24),
//               buildName(user),
//               const SizedBox(height: 24),
//               Center(child: buildUpgradeButton()),
//               const SizedBox(height: 24),
//               NumbersWidget(),
//               const SizedBox(height: 48),
//               buildAbout(user),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildName(User user) => Column(
//     children: [
//       Text(
//         user.name,
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//       ),
//       const SizedBox(height: 4),
//       Text(
//         user.email,
//         style: TextStyle(color: Colors.grey),
//       )
//     ],
//   );
//
//   Widget buildUpgradeButton() => ButtonWidget(
//     text: 'hehehe',
//     onClicked: () {},
//   );
//
//   Widget buildAbout(User user) => Container(
//     padding: EdgeInsets.symmetric(horizontal: 48),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'About',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 16),
//         Text(
//           user.about,
//           style: TextStyle(fontSize: 16, height: 1.4),
//         ),
//       ],
//     ),
//   );
//   Widget NumbersWidget() =>  Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       buildButton(context, '4.8', 'Ranking'),
//       buildDivider(),
//       buildButton(context, '35', 'Following'),
//       buildDivider(),
//       buildButton(context, '50', 'Followers'),
//     ],
//   );
//
//   Widget buildDivider() => Container(
//     height: 24,
//     child: VerticalDivider(),
//   );
//
//   Widget buildButton(BuildContext context, String value, String text) => MaterialButton(
//         padding: EdgeInsets.symmetric(vertical: 4),
//         onPressed: () {},
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               value,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             ),
//             SizedBox(height: 2),
//             Text(
//               text,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       );
//
//
// }

