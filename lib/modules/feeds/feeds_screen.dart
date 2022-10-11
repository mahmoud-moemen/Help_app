import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help/layout/layoutCubit/layout_cubit.dart';
import 'package:help/layout/layoutCubit/layout_states.dart';
import 'package:help/models/post_model.dart';
import 'package:help/modules/write_comment/write_comment_screen.dart';
import 'package:help/shared/components/components.dart';
import 'package:help/shared/styles/colors.dart';
import 'package:help/shared/styles/icon_broken.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';


class FeedsScreen extends StatelessWidget {
  // const FeedsScreen({Key? key}) : super(key: key);



  var categories = [
    "All",
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
  Widget build(BuildContext context)
  {
    return BlocConsumer<LayoutCubit , LayoutStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        var cubit = LayoutCubit.get(context);

        return  ConditionalBuilder(
          condition:cubit.posts.isNotEmpty && cubit.userModel != null,
          builder: (context)=> SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children:
              [

                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children:
                    [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/you-looked-much-better-your-avatar-unimpressed-indifferent-cute-man-glasses_176420-24041.jpg?w=740&t=st=1663225975~exp=1663226575~hmac=2867791d2999f7936074498f036b4b6ae1612fe06dc768e892023afe63a1b805'),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with experience',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
                /// categories
                Container(
                  height: 5.h,
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: (context,index)=>buildCategoryList(index,categories[index],context),

                  ),
                ),
                /// posts
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if(LayoutCubit.get(context).selectedFeedsCategory == 'All')
                    {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>buildPostItem(context,cubit.posts[index],index),
                        separatorBuilder:(context,index)=>SizedBox(height: 8.0) ,
                        itemCount: cubit.posts.length,
                      );
                    }else
                    {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>buildPostItem(context,cubit.postsWithCategory[index],index),
                        separatorBuilder:(context,index)=>SizedBox(height: 8.0) ,
                        itemCount: cubit.postsWithCategory.length,
                      );
                    }
                  },

                ),
                SizedBox(height: 5.0),
              ],
            ),
          ),
          fallback: (context)=>Center(
            child: LoadingAnimationWidget.hexagonDots(
              color: Colors.blue,
              size: 60,
            ),
          ),
        );
      },

    );

  }

  Widget buildPostItem(BuildContext context,PostModel model,index) =>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            children:
            [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  model.image!,

                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Row(
                      children:
                      [
                        Text(
                          model.name!,
                          style: TextStyle(
                              height: 1.4
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 17,
                        ),
                      ],
                    ),
                    Text(
                      model.dateTime!,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              IconButton(
                onPressed: (){},
                icon:Icon(
                  Icons.more_horiz,
                  size: 18.0,
                ),
              ),
            ],
          ),
          ///divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          /// post text
          Text(
              model.text!,
              style: Theme.of(context).textTheme.subtitle1
          ),
          ///hashtag
          // Padding(
          //   padding: const EdgeInsets.only(
          //       bottom: 10.0,top: 5.0
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children:
          //       [
          //         Padding(
          //           padding: EdgeInsetsDirectional.only(
          //               end: 6.0
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //                 padding: EdgeInsets.zero,
          //                 minWidth: 1.0,
          //
          //                 onPressed: (){},
          //                 child:Text(
          //                   '#software',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: defaultColor
          //                   ),
          //                 ) ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsetsDirectional.only(
          //               end: 6.0
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //                 padding: EdgeInsets.zero,
          //                 minWidth: 1.0,
          //
          //                 onPressed: (){},
          //                 child:Text(
          //                   '#software',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: defaultColor
          //                   ),
          //                 ) ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          /// post record (if exist)
          // if(model.postRecord != '')
          //   Container(
          //     alignment: Alignment.center,
          //     width: 80.w,
          //     margin: EdgeInsets.only(top: 10),
          //     child: VoiceMessage(
          //       audioSrc: model.postRecord!,
          //       me: true,
          //       played: true,
          //       onPlay: (){},
          //     ),
          //   ),
          /// image of the post (if exist)
          if (model.postImage !='')
            Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image:NetworkImage(
                      model.postImage!),
                  fit: BoxFit.cover,

                ),
              ),
            ),
          ),
          /// # of likes & comments
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0
            ),
            child: Row(

              children:
              [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                          vertical: 5.0
                      ),
                      child: Row(
                        children:
                        [
                          Icon(
                            IconBroken.Heart,
                            size: 16.0,
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            ///change here
                            ///
                            ///
                            LayoutCubit.get(context).isLiked[model.postId]==false?
                            '${LayoutCubit.get(context).likes[model.postId]}  '
                            :LayoutCubit.get(context).likes[model.postId]==1?
                            'You'
                            :'You and ${LayoutCubit.get(context).likes[model.postId]!-1} others',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: ()
                    {

                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(
                          vertical: 5.0
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${LayoutCubit.get(context).numberOfComments[model.postId]} comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          ///divider
          Padding(
            padding: const EdgeInsets.only(
                bottom: 10.0
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          /// write a comment & like button
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  child: Row(
                    children:
                    [
                      CircleAvatar(
                        radius: 19.0,
                        backgroundImage: NetworkImage(
                          '${LayoutCubit.get(context).userModel!.image}',

                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.caption!.copyWith(

                        ),
                      ),
                    ],
                  ),
                  onTap: ()
                  {
                    //LayoutCubit.get(context).getReplies(postId: model.postId!);
                    navigateTo(context, WriteCommentScreen(postModel:  model,index: index,));
                  },
                ),
              ),
              InkWell(
                child: Row(
                  children:
                  [
                    Icon(
                      ///change here
                      ///
                      ///
                      LayoutCubit.get(context).isLiked[model.postId]!?
                      Icons.favorite
                          :Icons.favorite_border_outlined,
                      size: 16.0,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: ()
                {
                  ///change here
                  ///
                  ///
                  if(LayoutCubit.get(context).isLiked[model.postId]!)
                  {
                    LayoutCubit.get(context).disLikePost(model.postId!,index);
                    LayoutCubit.get(context).getNumberOfLikes(model.postId!);
                  }else
                  {
                    LayoutCubit.get(context).likePost(model.postId!,index);
                    LayoutCubit.get(context).getNumberOfLikes(model.postId!);
                  }

                },
              ),
            ],
          ),

        ],
      ),
    ),

  );

  Widget buildCategoryList(int index, String categoryName,context) =>Container(
    height: 5.h,
    child: GestureDetector(
      onTap: ()
      {
        LayoutCubit.get(context).selectFeedsCategory( cat:categoryName );
        LayoutCubit.get(context).getPostsWithCategory();
         print('category clicked is: ${categories[index]}');
         print('selected Feeds Category : ${LayoutCubit.get(context).selectedFeedsCategory}');
         LayoutCubit.get(context).selectCategory(index: index);

      },
      child: Container(
        alignment:Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 2 .w),
        height: 5.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: LayoutCubit.get(context).selectedindex == index ? Colors.amber : Colors.grey.shade300,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            categoryName,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: index == LayoutCubit.get(context).selectedindex ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    ),
  );



}
