
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help/layout/layoutCubit/layout_cubit.dart';
import 'package:help/layout/layoutCubit/layout_states.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:swipe_to/swipe_to.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';
import '../../models/replay_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class WriteCommentScreen extends StatelessWidget {

  final PostModel postModel;
  final int index;



   WriteCommentScreen({Key? key, required this.postModel,required this.index}) : super(key: key);

  var commentController = TextEditingController();
  var FormKey=GlobalKey<FormState>();
  final focusNode = FocusNode();




  @override
  Widget build(BuildContext context)
  {
    return Builder(
      builder: (context) {
        LayoutCubit.get(context).getComments(postId: postModel.postId!);
        LayoutCubit.get(context).getNumberOfComments(postId:postModel.postId! );
        LayoutCubit.get(context).getReplies(postId: postModel.postId!);

        return BlocConsumer<LayoutCubit,LayoutStates>(
          listener: (context,state)
          {
            if(state is CreateReplaySuccessState)
            {
               //LayoutCubit.get(context).whenRepliesChange(postId:postModel.postId!, commentId: state.commentId);
            }
          },
          builder: (context,state)
          {
            return Scaffold(
              appBar: defaultAppBar(
                context:context,
                title: 'Write a comment',
              ),
              body: InkWell(
                onTap: ()
                {
                  FocusScope.of(context).unfocus();
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:
                      [
                        Card(
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
                                        postModel.image!,

                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:
                                      [
                                        Row(
                                          children:
                                          [
                                            Text(
                                              postModel.name!,
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
                                          '${postModel.dateTime!}',
                                          style: Theme.of(context).textTheme.caption!.copyWith(
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Spacer(),
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
                                Text(
                                    postModel.text!,
                                    style: Theme.of(context).textTheme.subtitle1
                                ),
                                /// hashtag
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
                                if (postModel.postImage !='')
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Container(
                                      height: 140.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.0),
                                        image: DecorationImage(
                                          image:NetworkImage(
                                              postModel.postImage!),
                                          fit: BoxFit.cover,

                                        ),
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0
                                  ),
                                  child: Row(
                                    /// likes & comments
                                    children:
                                    [
                                      InkWell(
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
                                                LayoutCubit.get(context).isLiked[postModel.postId]==false?
                                                '${LayoutCubit.get(context).likes[postModel.postId]}  '
                                                    :LayoutCubit.get(context).likes[postModel.postId]==1?
                                                'You'
                                                    :'You and ${LayoutCubit.get(context).likes[postModel.postId]!-1} others',
                                                style: Theme.of(context).textTheme.caption,
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: (){},
                                      ),
                                      Spacer(),
                                      InkWell(
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
                                                '${LayoutCubit.get(context).numberOfComments[postModel.postId]} comment',
                                                style: Theme.of(context).textTheme.caption,
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: (){},
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
                                Row(
                                  children:
                                  [
                                    InkWell(
                                      child: Row(
                                        children:
                                        [
                                          Icon(
                                            ///change here
                                            ///
                                            ///
                                            LayoutCubit.get(context).isLiked[postModel.postId]!?
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
                                        if(LayoutCubit.get(context).isLiked[postModel.postId]!)
                                        {
                                          LayoutCubit.get(context).disLikePost(postModel.postId!,index);
                                          LayoutCubit.get(context).getNumberOfLikes(postModel.postId!);
                                        }else
                                        {
                                          LayoutCubit.get(context).likePost(postModel.postId!,index);
                                          LayoutCubit.get(context).getNumberOfLikes(postModel.postId!);
                                        }

                                      },
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),

                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ///comments list
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            //itemBuilder: (context,index)=>buildComments(LayoutCubit.get(context).comments[index]),
                            itemBuilder: (context,index)=>LayoutCubit.get(context).replies[LayoutCubit.get(context).comments[index].commentId]!=null?
                                buildCommentsWithReplay(LayoutCubit.get(context).comments[index],
                              LayoutCubit.get(context).replies[LayoutCubit.get(context).comments[index].commentId]!
                            ):buildCommentsWithNoReplay(LayoutCubit.get(context).comments[index],context),
                            separatorBuilder: (context,index)=>SizedBox(height: 2),
                            itemCount: LayoutCubit.get(context).comments.length),
                        SizedBox(
                          height: 60,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              bottomSheet: buildWriteCommentsBox(context),
            );
          },
        );
      }
    );
  }

  Widget buildComments(CommentModel commentModel) =>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(
              commentModel.image!,

            ),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // shape: RoundedRectangleBorder(
          //     side: BorderSide(color: Colors.black54),
          //     borderRadius:BorderRadius.circular(10) ),
          child: Container(
            padding: EdgeInsetsDirectional.only(start: 8,end: 8,bottom: 8),
            width: 100.w - 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(commentModel.publisherName!),
                Text(
                  commentModel.commentText!,
                  style: TextStyle(
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildCommentsWithReplay(CommentModel commentModel,List<ReplayModel>replies) =>Container(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    child: CommentTreeWidget<Comment, Comment>(
      Comment(
          avatar: commentModel.image,
          userName: commentModel.publisherName,
          content: commentModel.commentText),
      ///replies


        replies.map((e){
        return Comment(
            avatar: e.image,
            userName: e.publisherName,
            content: e.replayText);
      }).toList()


      // Comment(
      //     avatar: 'null',
      //     userName: 'replay',
      //     content: 'this is a test replay to a comment '),
      // Comment(
      //     avatar: 'null',
      //     userName: 'null',
      //     content:
      //     'second replay'),
      // Comment(
      //     avatar: 'null',
      //     userName: 'null',
      //     content:
      //     'third replay'),
      ,

      treeThemeData:TreeThemeData(lineColor: Colors.blue[500]!,lineWidth: 1),
      avatarRoot: (context, data)=> PreferredSize(
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(data.avatar!),
          ),
          preferredSize: Size.fromRadius(18)),
      avatarChild:(context, data)=>PreferredSize(
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(data.avatar??'static'),

          ),
          preferredSize: Size.fromRadius(12)),
      contentRoot: (context, data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SwipeTo(
            //   iconSize: 0,
            //   onRightSwipe: ()
            //   {
            //     //replayToComment(commentModel);
            //     focusNode.requestFocus();
            //   },
            //   offsetDx: 0.6,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            //     decoration: BoxDecoration(
            //         color: Colors.grey[100],
            //         borderRadius: BorderRadius.circular(12)),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           '${data.userName}',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //               fontWeight: FontWeight.w600, color: Colors.black),
            //         ),
            //         SizedBox(
            //           height: 4,
            //         ),
            //         Text(
            //           '${data.content}',
            //           style: Theme.of(context).textTheme.caption!.copyWith(
            //               fontWeight: FontWeight.w300, color: Colors.black),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.userName}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${data.content}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.grey[700], fontWeight: FontWeight.bold),
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Text('Like'),
                    SizedBox(
                      width: 24,
                    ),
                    InkWell(
                      onTap: ()
                      {
                        LayoutCubit.get(context).replayToComment(commentModel: commentModel);
                        focusNode.requestFocus();

                      },
                        child: Text('Reply')),
                  ],
                ),
              ),
            )
          ],
        );
      },
      contentChild: (context, data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'dangngocduc',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${data.content}',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.grey[700], fontWeight: FontWeight.bold),
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Text('Like'),
                    SizedBox(
                      width: 24,
                    ),
                    Text('Reply'),
                  ],
                ),
              ),
            )
          ],
        );
      },


    ),
  );

  Widget buildWriteCommentsBox(context) =>Column(
    mainAxisSize: MainAxisSize.min,
    children:
    [
      if(LayoutCubit.get(context).isReplay == true &&LayoutCubit.get(context).commentModelToReplay != null )
        Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Row(
          children:
          [
            Text('you are replaying to:'
                ' ${LayoutCubit.get(context).commentModelToReplay!.publisherName}',
              style: TextStyle(color: Colors.blue),
            ),
            Spacer(),
            IconButton(
                onPressed: (){
                  LayoutCubit.get(context).cancelReplayToComment();
                  FocusScope.of(context).unfocus();
                  },
                icon: Icon(IconBroken.Close_Square)),
          ],
        ),
      ),
      ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

        tileColor: Colors.black54,
        leading: Container(
          height: 40.0,
          width: 40.0,
          decoration: new BoxDecoration(
              color: Colors.blue,
              borderRadius: new BorderRadius.all(Radius.circular(50))),
          child: CircleAvatar(
              radius: 50, backgroundImage: NetworkImage(LayoutCubit.get(context).userModel!.image!)),
        ),
        title: Form(
          key: FormKey,
          child: TextFormField(
            focusNode: focusNode,
            maxLines: 5,
            showCursor: false,
            textAlignVertical:TextAlignVertical.center ,
            minLines: 1,
            // focusNode: focusNode,
            // cursorColor: textColor,
            style: TextStyle(color: Colors.black54),
            controller: commentController,
            decoration: const InputDecoration(
              //labelText: 'Write a comment ...',
              hintText: 'Write a comment ...',
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.white),

            ),
            validator: (value) {
              if(value!.isEmpty)
              {
                return 'please write a comment';
              }else
              {
                return null ;
              }
            },
          ),
        ),
        trailing: GestureDetector(
          onTap: ()
          {
            if(FormKey.currentState!.validate())
            {
              if(LayoutCubit.get(context).isReplay && LayoutCubit.get(context).commentModelToReplay !=null)
              {
                LayoutCubit.get(context).createReplay(
                    Text: commentController.text,
                    postId: postModel.postId!,
                    commentId: LayoutCubit.get(context).commentModelToReplay!.commentId!);
                commentController.clear();
                FocusScope.of(context).unfocus();
                LayoutCubit.get(context).isReplay = false;
              }else
              {
                var now =DateTime.now();
                String formattedDate = DateFormat('yyyy-MM-dd – hh:mm a').format(now);

                LayoutCubit.get(context).createComment(
                    dateTime: formattedDate,
                    commentText: commentController.text,
                    postId: postModel.postId!);
                commentController.clear();
                FocusScope.of(context).unfocus();
              }
            }else
            {
              showToast(text: 'cant send empty comment', state: toastStates.WARNING);
            }
          },
          child: Icon(Icons.send_sharp, size: 30, color: Colors.black),
        ),
      ),
    ],
  );

  Widget buildCommentsWithNoReplay(CommentModel commentModel,BuildContext context) =>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        PreferredSize(
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(commentModel.image!),
            ),
            preferredSize: Size.fromRadius(18)),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${commentModel.publisherName}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${commentModel.commentText}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.grey[700], fontWeight: FontWeight.bold),
              child: Padding(
                padding: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Text('Like'),
                    SizedBox(
                      width: 24,
                    ),
                    InkWell(
                        onTap: ()
                        {
                          LayoutCubit.get(context).replayToComment(commentModel: commentModel);
                          focusNode.requestFocus();

                        },
                        child: Text('Reply')),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
