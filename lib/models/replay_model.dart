class ReplayModel
{
  String? publisherName;//
  String? uId;//
  String? image;//
  String? replayText;//




  ReplayModel({
    this.publisherName,
    this.uId,
    this.image,
    this.replayText,

  });

  ReplayModel.fromJson(Map<String,dynamic> json)
  {
    publisherName=json['publisherName'];
    uId =json['uId'];
    image =json['image'];
    replayText =json['replayText'];

  }

  Map<String,dynamic> toMap()
  {
    return{
      'publisherName':publisherName,
      'uId':uId,
      'image':image,
      'replayText':replayText,
    };
  }
}