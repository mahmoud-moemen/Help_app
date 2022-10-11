import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help/layout/app_layout.dart';
import 'package:help/layout/layoutCubit/layout_cubit.dart';
import 'package:help/modules/login/wlcome_screen.dart';
import 'package:help/shared/bloc_observer.dart';
import 'package:help/shared/components/constants.dart';
import 'package:help/shared/network/local/cache_helper.dart';
import 'package:help/shared/styles/themes.dart';
import 'package:sizer/sizer.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  uId = CacheHelper.getData(key: 'uId');
  Widget widget;
  if(uId != null)
  {
    widget= AppLayoutScreen();
  }else
  {
    widget = WelcomeScreen();
  }
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp( this.startWidget);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

return Sizer(builder: (context,orientation,deviceType){
  return MultiBlocProvider(
    providers:
    [
      BlocProvider(create: (context)=>LayoutCubit()..getUserData()..getPosts()),
    ],
    child: MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home:startWidget
      //startWidget,
    ),
  );
});

  }
}

