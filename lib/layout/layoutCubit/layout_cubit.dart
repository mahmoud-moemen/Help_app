import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help/models/comment_model.dart';
import 'package:help/models/replay_model.dart';
import 'package:help/modules/howToArrive/how_to_arrive.dart';
import 'package:help/modules/new_post/new_post_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../../modules/feeds/feeds_screen.dart';
import '../../modules/free/free_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/constants.dart';
import 'layout_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  List<String> titles = [
    'Feeds',
    'Free',
    'post',
    'Ezay',
    'Settings',
  ];

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    FreeScreen(),
    NewPostScreen(),
    HowToArrive(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {

    if(index == 2)
      emit(LayoutAddNewPostState());
    else
    {
      currentIndex = index;
      emit(LayoutChangeBottomNavState());
    }

  }

////////////////////////////////////////////////////////

  UserModel? userModel;

  void getUserData()
  {
    emit(LayoutGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {
      userModel=UserModel.fromJson(value.data()!);
      emit(LayoutGetUserDataSuccessState());
    })
        .catchError((error)
    {
          emit(LayoutGetUserDataErrorState(error.toString()));
    });
  }
///////////////////////////////////////////////create new post/////////////////////////////////////////////////////////




/// for select category (in feeds screen , new post screen)
  var selectedCategory = "";
  int selectedindex = 0;
  void selectCategory({String? cat,int? index})
  {
    if(cat != null)
    {
      selectedCategory=cat;


    }else
    {
      selectedindex =index!;
    }
    emit(SelectCategoryState());
  }


  var selectedFeedsCategory = "All";
  void selectFeedsCategory({required String cat})
  {

    selectedFeedsCategory=cat;
    emit(SelectCategoryState());
  }



  Future<void> selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text('Create a post'),
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SimpleDialogOption(
                  child: Text('Take a photo'),
                  onPressed: () async {
                    Navigator.pop(context);
                    getPostImage(ImageSource.camera);
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SimpleDialogOption(
                  child: Text('Choose from Gallery'),
                  onPressed: () async {
                    Navigator.pop(context);
                   getPostImage(ImageSource.gallery);
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SimpleDialogOption(
                  child: Text('Cancel',textAlign: TextAlign.center,style: TextStyle(color: Colors.redAccent)),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
  }

  File? postImage;
  final ImagePicker picker = ImagePicker();
  Future<void> getPostImage(ImageSource source)async
  {
    //  profileImage = await _picker.pickImage(source: ImageSource.gallery) as file?;
    XFile? image = (await picker.pickImage(source: source)) ;
    if(image !=null)
    {
      postImage = File(image.path);
      emit(PostImagePickedSuccessState());
    }else
    {
      print('No image selected');
      emit(PostImagePickedErrorState());
    }
  }


  void removePostImage()
  {
    postImage = null;
    emit(RemovePostImageState());
  }


  void uploadPostImage({

    required String dateTime,
    required String postCategory,
    required String text,

  })
  {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value)
    {
      value.ref.getDownloadURL()
          .then((value)
      {

        print(value);

        createPost(dateTime: dateTime, text: text,postImage: value,postCategory: postCategory);

      })
          .catchError((error)
      {
        emit(CreatePostErrorState());
      });
    })
        .catchError((error)
    {
      emit(CreatePostErrorState());
    });
  }


  void createPost({
    required String dateTime,
    required String text,
    required String postCategory,
    String? postImage,
    String? postRecord,
  })
  {
    emit(CreatePostLoadingState());
    ///generate random post id
    String postId= const Uuid().v4();

    PostModel model =PostModel(
      name: userModel!.name,
      image:userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage:postImage??'',
      postRecord:postRecord??'',
      postId:postId,
      postCategory: postCategory

    );

    FirebaseFirestore.instance
        .collection('posts')
    .doc(postId)
    .set(model.toMap())
        .then((value)
    {

      emit(CreatePostSuccessState());
    })
        .catchError((error)
    {
      emit(CreatePostErrorState());
    });
  }

  /////////////////////////////////get posts///////////////////////////////////////////////
  List<PostModel> posts = [];
  /// 34an agyb 3dd al likes 3la kol post
  // List<int> likes = [];
  // List<bool> isLiked = [];
  Map<String,int> likes = {};
  Map<String,int> numberOfComments = {};
  Map<String,bool> isLiked = {};
  ///real time (posts only)

void getPosts()
{
  emit(GetPostsLoadingState());
  FirebaseFirestore.instance
      .collection('posts')
      .snapshots()
      .listen((event) {
    posts=[];
    for (var post in event.docs) {

      post.reference.collection('comments').get().then((value) {
        numberOfComments[post.id]=value.docs.length;

      });


      post.reference
          .collection('likes')
          .get()
          .then((value) {


        if(value.docs.isNotEmpty)
        {
          value.docs.forEach((element) {

            if(element.id == userModel!.uId )
            {
              isLiked[post.id]=true;
            }else
            {
              isLiked[post.id]=false;
            }
          });
        }else
        {
          isLiked[post.id]=false;
        }


        //likes.add(value.docs.length);
        likes[post.id]=value.docs.length;
        posts.add(PostModel.fromJson(post.data()));


        emit(GetPostsSuccessState());
      })
          .catchError((error){
        emit(GetPostsErrorState(error.toString()));
      });
    }
  });

}

/// stream 3la  number of likes
 void getNumberOfLikes(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .snapshots()
        .listen((event) {
      //likes[postId]= event.docs.length;
      likes[postId]=event.docs.length;
      emit(GetNumberOfLikesSuccessState());
    });
  }


void likePost(String postId,int index)
{
  FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('likes')
      .doc(userModel!.uId)
      .set({
    'like':true
  })
      .then((value)
  {
    //isLiked[postId] =true;
    isLiked[postId] = true;
    emit(LikePostSuccessState());
  })
      .catchError((error){
        print(error.toString());
    emit(LikePostErrorState());

  });
}

void disLikePost(String postId,int index)
{
  FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('likes')
      .doc(userModel!.uId)
      .delete()
      .then((value)
  {
    //isLiked[postId]=false;
    isLiked[postId]=false;
    emit(DisLikePostSuccessState());
  })
      .catchError((error)
  {
    emit(DisLikePostErrorState());
  });
}
///////////////////////////get posts with category///////////////////////////////////
  List<PostModel> postsWithCategory = [];
  void getPostsWithCategory()
  {
   postsWithCategory=posts.where((element) {
     final postCatLower = element.postCategory!.toLowerCase();
     final searchLower = selectedFeedsCategory.toLowerCase();
     
     return postCatLower.contains(searchLower);
   }).toList();

   emit(GetPostsWithCategoryState());

  }
////////////////////////////////////Comments////////////////////////////////////

void createComment({
  required String dateTime,
  required String commentText,
  required String postId,
})
{

  String commentId= const Uuid().v4();

  emit(CreateCommentLoadingState());
  CommentModel commentModel = CommentModel(
     image: userModel!.image,
     uId: userModel!.uId,
     publisherName: userModel!.name,
     datePublished:dateTime ,
     commentId: commentId,
     commentText: commentText
  );

  FirebaseFirestore.instance.collection('posts')
  .doc(postId)
  .collection('comments')
  .doc(commentId)
      .set(commentModel.toMap())
      .then((value) {
        emit(CreateCommentSuccessState());
  })
      .catchError((error){
        if (kDebugMode) {
          print(error.toString());
        }
        emit(CreateCommentErrorState());
  });

}

/// stream 3la number of comments
  void getNumberOfComments({required String postId})
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .listen((event) {
      //likes[postId]= event.docs.length;
      numberOfComments[postId]=event.docs.length;
      emit(GetNumberOfCommentsSuccessState());
    });
  }


  List<CommentModel> comments=[];
  void getComments({
    required String postId,
  })
  {

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('datePublished')
        .snapshots()
        .listen((event)
    {
      comments=[];
      event.docs.forEach((element)
      {
        comments.add(CommentModel.fromJson(element.data()));
      });
      emit(GetCommentsSuccessState());
    });
  }

////////////////////////////////////////////////////////////////////////////
///         replies
  ///
void createReplay({
  required String Text,
  required String postId,
  required String commentId,

})
{
  emit(CreateReplayLoadingState());

  ReplayModel replayModel= ReplayModel(
    publisherName:userModel!.name ,
    uId: userModel!.uId,
    image: userModel!.image,
    replayText: Text,
  );

  FirebaseFirestore.instance.collection('posts')
  .doc(postId)
  .collection('comments')
  .doc(commentId)
  .collection('replies')
  .add(replayModel.toMap())
      .then((value){
        emit(CreateReplaySuccessState(commentId));
  })
      .catchError((error){
        emit(CreateReplayErrorState());
  });
}

bool isReplay = false ;
CommentModel? commentModelToReplay;
void replayToComment({required CommentModel commentModel})
{
  isReplay = true;
  commentModelToReplay = commentModel;
  print(commentModelToReplay!.commentId);
  emit(createReplayState());

}

void cancelReplayToComment()
{

  isReplay = false;
  commentModelToReplay = null;
  print(commentModelToReplay);
  emit(CancelReplayState());
}



  ///get replies real time but (has an error)
Map<String,List<ReplayModel>?> replies = {};
List<ReplayModel> commentReplies=[];
void getReplies({
  required String postId
})
{
  FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('comments')
      .snapshots()
      .listen((event)
  {
    event.docs.forEach((comment)
    {
      comment.reference
          .collection('replies')
       .snapshots()
       .listen((event) {
        // replies = {};
        commentReplies = [];

        if(event.docs.isNotEmpty )
        {

          event.docs.forEach((replay)
          {

            commentReplies.add(ReplayModel.fromJson(replay.data()));
            //replies[comment.id] = commentReplies;
          });
          replies[comment.id] = commentReplies;
        }else
        {
          replies[comment.id] = null;
          //commentReplies.add(null);
        }


        emit(GetReplaySuccessState());
      });



    });
    print('al map :${replies}');
    emit(GetReplaySuccessState());
  });

}


}





///
//   File? postRecord;
//  void getPostRecord(File soundFile){
//
//    postRecord = soundFile;
//    print("the path from cubit is:::: ${soundFile}");
//    emit(GetPostRecordState());
// }
//
// void removePostRecord()
// {
//   postRecord=null;
//   emit(RemovePostRecordState());
// }

/// el upload record moethod
//   File? postRecord;
//   void uploadPostImageAndRecord({
//
//     required String dateTime,
//     required String postCategory,
//     required String text,
//
//   })
//   {
//     emit(CreatePostLoadingState());
//     firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child('postsImage/${Uri.file(postImage!.path).pathSegments.last}')
//         .putFile(postImage!)
//         .then((image)
//     async {
//       String  imageUrl = await image.ref.getDownloadURL();
//       firebase_storage.FirebaseStorage.instance
//           .ref()
//           .child('postsRecord/${Uri.file(postRecord!.path).pathSegments.last}')
//           .putFile(postRecord!).then((record) =>{
//             record.ref.getDownloadURL()
//                 .then((recordUrl) {
//
//                   createPost(
//                       dateTime: dateTime,
//                       text: text,
//                       postCategory: postCategory,
//                       postImage: imageUrl ,
//                     postRecord: recordUrl
//
//                   );
//
//             })
//       } );
//
//     }).catchError((error)
//     {
//       emit(CreatePostErrorState());
//     });
//   }


///get replies real time but (has an error)
// Map<String,List<ReplayModel>?> replies = {};
// List<ReplayModel> commentReplies=[];
// void getReplies({
//   required String postId
// })
// {
//   FirebaseFirestore.instance
//       .collection('posts')
//       .doc(postId)
//       .collection('comments')
//       .get()
//       .then((value)
//   {
//     value.docs.forEach((comment)
//     {
//       comment.reference
//           .collection('replies')
//        .snapshots()
//        .listen((event) {
//         // replies = {};
//         commentReplies = [];
//
//         if(event.docs.isNotEmpty )
//         {
//
//           event.docs.forEach((replay)
//           {
//
//             commentReplies.add(ReplayModel.fromJson(replay.data()));
//             //replies[comment.id] = commentReplies;
//           });
//           replies[comment.id] = commentReplies;
//         }else
//         {
//           replies[comment.id] = null;
//           //commentReplies.add(null);
//         }
//
//
//
//       });
//
//
//
//     });
//     print('al map :${replies}');
//     emit(GetReplaySuccessState());
//   })
//       .catchError((error)
//   {
//
//   });
// }


///get replies (working) but not real time
//   Map<String,List<ReplayModel>?> replies = {};
// void getReplies({
//   required String postId
// })
// {
//   emit(GetReplayLoadingState());
//   FirebaseFirestore.instance
//       .collection('posts')
//       .doc(postId)
//       .collection('comments')
//       .get()
//       .then((value)
//   {
//     value.docs.forEach((comment)
//     {
//       comment.reference
//           .collection('replies')
//       // .snapshots()
//       // .listen((event) { })
//           .get()
//           .then((value)
//       {
//         List<ReplayModel> commentReplies=[];
//         if(value.docs.isNotEmpty )
//         {
//
//            value.docs.forEach((replay)
//            {
//
//              commentReplies.add(ReplayModel.fromJson(replay.data()));
//              replies[comment.id] = commentReplies;
//            });
//         }else
//         {
//           replies[comment.id] = null;
//         }
//
//         //replies[comment.id] = commentReplies;
//         commentReplies = [];
//         // emit(GetReplaySuccessState());
//         //print('al map bta3t al replaies : $replies');
//
//       });
//
//     });
//     emit(GetReplaySuccessState());
//   })
//       .catchError((error)
//   {
//     emit(GetReplayErrorState());
//   });
//
// }


///get posts not real time
// void getPosts()
// {
//   emit(GetPostsLoadingState());
//   FirebaseFirestore.instance
//       .collection('posts')
//       .get()
//       .then((value)
//   {
//     value.docs.forEach((element) {
//
//
//         // likes.add(value.docs.length);
//         // postsId.add(element.id);
//         posts.add(PostModel.fromJson(element.data()));
//
//
//
//     });
//     emit(GetPostsSuccessState());
//
//   })
//       .catchError((error)
//   {
//     emit(GetPostsErrorState(error.toString()));
//
//   });
// }

// void getPosts()
// {
//   emit(GetPostsLoadingState());
//   FirebaseFirestore.instance
//       .collection('posts')
//       .snapshots()
//   .listen((event) {
//     posts = [];
//     event.docs.forEach((element) {
//       posts.add(PostModel.fromJson(element.data()));
//     });
//     emit(GetPostsSuccessState());
//   });
// }

///get posts not real time
// void getPosts()
// {
//   emit(GetPostsLoadingState());
//   FirebaseFirestore.instance
//       .collection('posts')
//       .get()
//       .then((value)
//   {
//     value.docs.forEach((element) {
//
//       element.reference.collection('likes').get()
//       .then((value)
//       {
//         if(value.docs.isNotEmpty)
//         {
//           value.docs.forEach((element) {
//             if(element.id == userModel!.uId )
//             {
//               isLiked.add(true);
//             }else
//             {
//               isLiked.add(false);
//             }
//           });
//         }else
//         {
//           isLiked.add(false);
//         }
//         likes.add(value.docs.length);
//         posts.add(PostModel.fromJson(element.data()));
//
//         emit(GetPostsSuccessState());
//       })
//       .catchError((error){
//         emit(GetPostsErrorState(error.toString()));
//       });
//
//
//     });
//
//
//   }).catchError((error)
//   {
//     emit(GetPostsErrorState(error.toString()));
//
//   });
// }



//////////////////////////////////post like & dislike //////////////////////////////////////////

///real time (posts only)
// void getPosts()
// {
//   emit(GetPostsLoadingState());
//   FirebaseFirestore.instance
//       .collection('posts')
//       .snapshots()
//       .listen((event) {
//     posts=[];
//     for (var element in event.docs) {
//       element.reference
//           .collection('likes')
//           .get()
//           .then((value) {
//
//         if(value.docs.isNotEmpty)
//         {
//           value.docs.forEach((element) {
//             if(element.id == userModel!.uId )
//             {
//               isLiked.add(true);
//             }else
//             {
//               isLiked.add(false);
//             }
//           });
//         }else
//         {
//           isLiked.add(false);
//         }
//
//
//         likes.add(value.docs.length);
//         posts.add(PostModel.fromJson(element.data()));
//         emit(GetPostsSuccessState());
//       })
//           .catchError((error){
//         emit(GetPostsErrorState(error.toString()));
//       });
//     }
//   });
//
// }

 /// get posts(real time)
// void getPosts()
// {
//   emit(GetPostsLoadingState());
//   FirebaseFirestore.instance
//       .collection('posts')
//       .snapshots()
//       .listen((event) {
//     posts=[];
//
//     for (var element in event.docs) {
//       element.reference
//           .collection('likes')
//           .snapshots()
//           .listen((event)
//       {
//
//         //isLiked = [];
//         //likes = [];
//         if(event.docs.isNotEmpty)
//         {
//
//           event.docs.forEach((element) {
//             if(element.id == userModel!.uId )
//             {
//               isLiked.add(true);
//             }else
//             {
//               isLiked.add(false);
//             }
//           });
//         }else
//         {
//           isLiked.add(false);
//         }
//
//         likes.add(event.docs.length);
//         posts.add(PostModel.fromJson(element.data()));
//         emit(GetPostsSuccessState());
//       });
//
//     }
//   });
//
// }

