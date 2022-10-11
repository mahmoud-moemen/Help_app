import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';
import '../../layout/layoutCubit/layout_cubit.dart';
import '../../layout/layoutCubit/layout_states.dart';
import '../../shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  var FormKey=GlobalKey<FormState>();
  var textController = TextEditingController();

  // var categories = [
  //   "Technology",
  //   "Education",
  //   "Programming",
  //   "Shopping",
  //   "Medical",
  //   "Freelancing",
  //   "Other"
  // ];

  var categories = [
    "Technology",
    "Free",
    "Ezay aro7",
    "Education",
    "Programming",
    "Shopping",
    "Medical",
    "Freelancing",
    "Other"
  ];




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context , state)
      {
        if (state is CreatePostSuccessState)
        {
          Navigator.of(context).pop();
          LayoutCubit.get(context).selectCategory(cat: '');
        }
      },
      builder: (context,state)
      {
        var cubit = LayoutCubit.get(context);

        return  Scaffold(
          appBar: defaultAppBar(
            context:context,
            title: 'Create post',

            actions:
            [
              defaultTextButton(callback: ()
              {
                if(FormKey.currentState!.validate() && LayoutCubit.get(context).selectedCategory != '')
                {
                  var now =DateTime.now();
                  String formattedDate = DateFormat('yyyy-MM-dd – hh:mm a').format(now);
                  if (cubit.postImage == null)
                  {
                    cubit.createPost(
                        dateTime: formattedDate,
                        text: textController.text,
                        postCategory: LayoutCubit.get(context).selectedCategory);
                  }
                  else if(cubit.postImage !=null )
                  {
                    // var now =DateTime.now();
                    // String formattedDate = DateFormat('yyyy-MM-dd – hh:mm a').format(now);
                    cubit.uploadPostImage(
                        dateTime:formattedDate,
                        text: textController.text,
                        postCategory: LayoutCubit.get(context).selectedCategory
                    );
                  }

                }else if(LayoutCubit.get(context).selectedCategory =='' && FormKey.currentState!.validate())
                {
                  showToast(text: 'select category', state: toastStates.WARNING);
                }
                else
                {
                  showToast(text: 'cant create empty post', state: toastStates.WARNING);
                }

              },
                  text: 'post'),


            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is CreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        LayoutCubit.get(context).userModel!.image!,

                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'mahmoud moemen',
                        style: TextStyle(
                            height: 1.4
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  decoration: BoxDecoration(
                    //  color: primaryColor
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(12)),
                  child: DropdownButton<String>(
                    alignment: AlignmentDirectional.center,
                    borderRadius: BorderRadius.circular(20),

                    underline: SizedBox(),
                    //isExpanded: true,
                    hint: LayoutCubit.get(context).selectedCategory == ''
                        ?
                    Text('Select Category')
                        : Text(
                      LayoutCubit.get(context).selectedCategory,
                      style: TextStyle(color: Colors.blue),
                    ),
                    items: categories.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (selectedCategory)
                    {
                      LayoutCubit.get(context).selectCategory(cat: selectedCategory!);
                    },
                  ),
                ),
                SizedBox(height: 20),
                /// layout builder
                // LayoutBuilder(builder: (context, constraints) {
                //   if(cubit.postRecord != null)
                //   {
                //     return SwipeTo(
                //       onRightSwipe: ()
                //       {
                //         cubit.removePostRecord();
                //       },
                //       iconOnRightSwipe: Icons.delete,
                //       animationDuration: const Duration(seconds: 1),
                //       child: Container(
                //         width: 80.w,
                //         child: VoiceMessage(audioSrc: cubit.postRecord!.path, me: true),
                //       ),
                //     );
                //   }else
                //   {
                //     return Expanded(
                //       child: Form(
                //         key:FormKey ,
                //         child: TextFormField(
                //           controller: textController,
                //           decoration:  const InputDecoration(
                //               hintText: 'What is on your mind ... ',
                //               border: InputBorder.none
                //           ),
                //           validator: (value) {
                //             if(value!.isEmpty)
                //             {
                //               return '';
                //             }else
                //             {
                //               return null ;
                //             }
                //           },
                //         ),
                //       ),
                //     );
                //   }
                //
                // },),

                Expanded(
                  child: Form(
                    key:FormKey ,
                    child: TextFormField(
                      controller: textController,
                      maxLines: 5,
                      decoration:  const InputDecoration(
                          hintText: 'What is on your mind ... ',
                          border: InputBorder.none
                      ),
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return '';
                        }else
                        {
                          return null ;
                        }
                      },
                    ),
                  ),
                ),
                /// post record
                // if(cubit.postRecord != null)
                //   SwipeTo(
                //           onRightSwipe: ()
                //           {
                //             cubit.removePostRecord();
                //           },
                //           iconOnRightSwipe: Icons.delete,
                //           animationDuration: const Duration(seconds: 1),
                //           child: Container(
                //             width: 80.w,
                //             margin: EdgeInsets.only(bottom: 10),
                //             child: VoiceMessage(
                //                 audioSrc: cubit.postRecord!.path,
                //                 me: true,
                //             ),
                //           ),
                //         ),
                if(cubit.postImage !=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children:
                    [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image:FileImage(cubit.postImage!)as ImageProvider,
                            fit: BoxFit.cover,

                          ),
                        ),
                      ),
                      IconButton(
                          icon:CircleAvatar(

                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ) ,
                          onPressed: ()
                          {
                            cubit.removePostImage();
                          }),
                    ],
                  ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children:
                  [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          cubit.selectImage(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(
                                IconBroken.Image
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text(
                          '# tags',
                        ),
                      ),
                    ),
                    /// social media recorder (not working)
                    // Expanded(
                    //   flex: 2,
                    //   child: Align(
                    //     alignment: Alignment.centerRight,
                    //     child: SocialMediaRecorder(
                    //
                    //         sendRequestFunction:(soundFile)
                    //         {
                    //           LayoutCubit.get(context).getPostRecord(soundFile);
                    //           print("the current path is ${soundFile.path}");
                    //         },
                    //
                    //       encode: AudioEncoderType.AAC_HE,
                    //
                    //
                    //     ),
                    //   ),
                    // ),

                  ],
                ),
              ],
            ),
          ),




        );
      },
    );
  }
}
