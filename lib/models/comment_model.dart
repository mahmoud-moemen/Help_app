class CommentModel
{
  String? publisherName;//
  String? uId;//
  String? image;//
  String? datePublished;//
  String? commentText;//
  String? commentId;//



  CommentModel({
    this.publisherName,
    this.uId,
    this.image,
    this.datePublished,
    this.commentText,
    this.commentId,
  });

  CommentModel.fromJson(Map<String,dynamic> json)
  {
    publisherName=json['publisherName'];
    uId =json['uId'];
    image =json['image'];
    datePublished =json['datePublished'];
    commentText =json['commentText'];
    commentId =json['commentId'];


  }

  Map<String,dynamic> toMap()
  {
    return{
      'publisherName':publisherName,
      'uId':uId,
      'image':image,
      'datePublished':datePublished,
      'commentText':commentText,
      'commentId':commentId,



    };
  }
}