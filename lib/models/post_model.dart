class PostModel
{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postRecord;
  String? postId;
  String? postCategory;


  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.postRecord,
    this.postId,
    this.postCategory
  });

  PostModel.fromJson(Map<String,dynamic> json)
  {
    name=json['name'];
    uId =json['uId'];
    image =json['image'];
    dateTime =json['dateTime'];
    text =json['text'];
    postImage =json['postImage'];
    postRecord =json['postRecord'];
    postId =json['postId'];
    postCategory =json['postCategory'];

  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
      'postRecord':postRecord,
      'postId':postId,
      'postCategory': postCategory,


    };
  }
}