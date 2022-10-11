import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help/models/user_model.dart';
import 'package:help/modules/edit_profile/edit_profile_screen.dart';
import 'package:help/shared/components/components.dart';

import '../../layout/layoutCubit/layout_cubit.dart';
import '../../layout/layoutCubit/layout_states.dart';
import '../../shared/components/animation.dart';
import '../../shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = LayoutCubit.get(context);
        var userModel = cubit.userModel;

        return ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: 'https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg?w=740&t=st=1663226550~exp=1663227150~hmac=37f49694ab732692b0e13c373e927612afe8f9cb80c171b006738457d3ddcfe0',
              color: Colors.blue,
              isEdit: true,
              onClicked: () {
                navigateTo(context, const EditProfileScreen());
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => EditProfileScreen()),
                // );
              },
            ),
            const SizedBox(height: 24),
            buildName(userModel!),
            const SizedBox(height: 24),
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 24),
            NumbersWidget(context),
            const SizedBox(height: 48),
            buildAbout(userModel),
          ],
        );
      },

    );

  }

  Widget ProfileWidget({required String imagePath, required bool isEdit, required VoidCallback onClicked,required Color color})
  => Center(
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
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

///////////////////////////////////////////////
  Widget NumbersWidget(context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildButton(context, '4.8', 'Ranking'),
      buildDivider(),
      buildButton(context, '35', 'Following'),
      buildDivider(),
      buildButton(context, '50', 'Followers'),
    ],
  );

  Widget buildDivider() => Container(
    height: 24,
    child: VerticalDivider(),
  );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

////////////////////////////////////////////////////////

  Widget buildName(UserModel model) => Column(
    children: [
      Text(
        model.name!,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        model.bio!,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'hehehe',
    onClicked: () {},
  );

  Widget ButtonWidget({required String text,required VoidCallback onClicked}) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: StadiumBorder(),
      onPrimary: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    ),
    child: Text(text),
    onPressed: onClicked,
  );


  Widget buildAbout(UserModel user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.bio!,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );



}
