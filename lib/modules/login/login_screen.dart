import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help/layout/app_layout.dart';
import 'package:help/layout/layoutCubit/layout_cubit.dart';
import 'package:help/modules/signUp/verify_email_screen.dart';
import 'package:help/shared/styles/icon_broken.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/loginCubit.dart';
import 'cubit/loginStates.dart';


class LoginScreen  extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state)
        {
          if(state is UserLoginErrorState)
          {
            showToast(text: state.error, state: toastStates.ERROR);
          }
          if(state is UserLoginSuccessState)
          {
            // StreamBuilder<User?>(
            //   stream:  FirebaseAuth.instance.authStateChanges(),
            //   builder: (context,snapshot)
            //   {
            //     if(snapshot.hasData)
            //     {
            //       return VerifyEmailScreen();
            //     }
            //     else
            //     {
            //       return LoginScreen();
            //     }
            //   },
            // );


            CacheHelper.saveData(key: 'uId', value: state.uId)
                .then((value)
            {
              navigateAndFinish(context, VerifyEmailScreen());
            })
                .catchError((error)
            {

            });
          }
        },
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children:
                      [
                        Text(
                          'LOGIN',
                          style:Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'Login Now To Get The Experience Of Other people ',
                          style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your email address';
                              }
                              return null;

                            },
                            label: 'Email Address',
                            prefix:Icons.email_outlined),
                        SizedBox(height: 20.0,),
                        defaultTextFormField(
                            controller: passwordController,
                            // onSubmitted: (value)
                            // {
                            //   if (formKey.currentState != null && formKey.currentState!.validate())
                            //   {
                            //
                            //     // LoginCubit.get(context).userLogin(
                            //     // email: emailController.text,
                            //     // password:passwordController.text );
                            //   }
                            // },
                            type: TextInputType.visiblePassword,
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your password';
                              }
                              return null;


                            },
                            label: 'Password',
                            prefix:IconBroken.Password,
                            isPassword:LoginCubit.get(context).isPassword,
                            suffix:LoginCubit.get(context).suffix ,
                            suffixPressed: ()
                            {
                              LoginCubit.get(context).changePasswordVisibility();
                            }),
                        SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition:true,
                          builder:(context)=>defaultButton(
                              callback: ()
                              {
                                if (formKey.currentState != null && formKey.currentState!.validate())
                                {

                                  LoginCubit.get(context).userLogin
                                    (
                                      email: emailController.text,
                                      password:passwordController.text );
                                  /// el method de test for complete login
                                  //LayoutCubit.get(context).getUserData();
                                }

                              },
                              text:'login'  ) ,
                          fallback:(context)=> Center(child: CircularProgressIndicator()),

                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,

      ),
    );
  }
}
