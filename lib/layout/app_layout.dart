import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help/layout/layoutCubit/layout_cubit.dart';
import 'package:help/layout/layoutCubit/layout_states.dart';
import 'package:help/modules/new_post/new_post_screen.dart';
import 'package:help/shared/components/components.dart';
import 'package:help/shared/styles/icon_broken.dart';

class AppLayoutScreen extends StatelessWidget {
  const AppLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state)
      {
        if (state is LayoutAddNewPostState)
        {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context,state)
      {
        var cubit = LayoutCubit.get(context);

        return Scaffold(
          appBar:  AppBar(
            // backgroundColor: Colors.black54,
            title:  Text(
                cubit.titles[cubit.currentIndex]
              //cubit.titles[cubit.currentIndex],
            ),
            actions:
            [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            currentIndex: cubit.currentIndex,

            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items:
            [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Heart),label: 'Free'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Add post'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Ezay'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),
            ],
          ) ,
        );
      },

    );
  }
}
