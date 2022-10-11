import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help/layout/layoutCubit/layout_cubit.dart';

import '../../layout/layoutCubit/layout_states.dart';
import '../../shared/components/text_field_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit , LayoutStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var userModel = LayoutCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Edit your profile'
            ),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: userModel!.image!,
                isEdit: true,
                color: Colors.blue,
                onClicked: () async {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: userModel.name!,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: userModel.email!,
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'About',
                text: userModel.bio!,
                maxLines: 5,
                onChanged: (about) {},
              ),
              const SizedBox(height: 10),

            ],
          ),
        );
      },

    );
  }


  Widget ProfileWidget({required String imagePath, required bool isEdit, required VoidCallback onClicked,required Color color}) => Center(
    child: Stack(
      children: [
        buildImage(imagePath,onClicked),
        Positioned(
          bottom: 0,
          right: 4,
          child: buildEditIcon( color, isEdit),
        ),
      ],
    ),
  );

  Widget buildImage(String imagePath,VoidCallback onClicked) {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color,bool isEdit) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        isEdit ? Icons.add_a_photo : Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) => ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
