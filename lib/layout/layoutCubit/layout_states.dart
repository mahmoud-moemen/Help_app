
abstract class LayoutStates{}

class LayoutInitialState extends LayoutStates{}

class LayoutChangeBottomNavState extends LayoutStates{}

class LayoutAddNewPostState extends LayoutStates{}

class LayoutGetUserDataLoadingState extends LayoutStates{}
class LayoutGetUserDataSuccessState extends LayoutStates{}
class LayoutGetUserDataErrorState extends LayoutStates{
  final String error;
  LayoutGetUserDataErrorState(this.error);
}


//////////////////create post///////////////////////////////////
class CreatePostLoadingState extends LayoutStates{}
class CreatePostSuccessState extends LayoutStates{}
class CreatePostErrorState extends LayoutStates{}

class PostImagePickedSuccessState extends LayoutStates{}
class PostImagePickedErrorState extends LayoutStates{}


class RemovePostImageState extends LayoutStates{}

class SelectCategoryState extends LayoutStates{}

//////////////////get posts/////////////////////////////////////

class GetPostsLoadingState extends LayoutStates{}
class GetPostsSuccessState extends LayoutStates{}
class GetPostsErrorState extends LayoutStates{
  final String error;
  GetPostsErrorState(this.error);
}

/////////////////////////////like post ///////////////////////////////////

class LikePostSuccessState extends LayoutStates{}
class LikePostErrorState extends LayoutStates{}

class DisLikePostSuccessState extends LayoutStates{}
class DisLikePostErrorState extends LayoutStates{}


class GetNumberOfLikesSuccessState extends LayoutStates{}

///////////////////////////////Comments states/////////////////////////////////////////////

class CreateCommentLoadingState extends LayoutStates{}
class CreateCommentSuccessState extends LayoutStates{}
class CreateCommentErrorState extends LayoutStates{}

class GetCommentsSuccessState extends LayoutStates{}

class GetNumberOfCommentsSuccessState extends LayoutStates{}

//////////////////////////////replies///////////////////////////////////////////////////

class CreateReplayLoadingState extends LayoutStates{}
class CreateReplaySuccessState extends LayoutStates{
  final String commentId;
  CreateReplaySuccessState(this.commentId);
}
class CreateReplayErrorState extends LayoutStates{}

///states 34an bgrb al replay to comment
class CancelReplayState extends LayoutStates{}
class createReplayState extends LayoutStates{}

/// get replies
class GetReplayLoadingState extends LayoutStates{}
class GetReplaySuccessState extends LayoutStates{}
class GetReplayErrorState extends LayoutStates{}



class GetPostsWithCategoryState extends LayoutStates{}


