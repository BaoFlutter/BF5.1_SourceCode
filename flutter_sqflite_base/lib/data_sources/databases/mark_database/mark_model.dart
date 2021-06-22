class MarkModel{

  int id;
  String user_name;
  double math_mark ;
  double liteture_mark;
  double english_mark ;

  MarkModel({this.id, this.user_name, this.math_mark, this.liteture_mark,
      this.english_mark});

  Map<String, dynamic> toJson()
  {
    return {
    "id":this.id,
    "user_name":this.user_name,
    "math_mark":this.math_mark,
  "liteture_mark":this.liteture_mark,
  "english_mark":this.english_mark,
    };
  }

  factory MarkModel.fromJson(json)
  {
    return MarkModel(
      id: json['id'],
      user_name: json['user_name'],
      math_mark: json['math_mark'],
      liteture_mark: json['liteture_mark'],
      english_mark: json['english_mark'],
    );

  }
}