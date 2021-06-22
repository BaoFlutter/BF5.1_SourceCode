abstract class WordModel {
  int? word_id;
  String? word ;
  String? pronounce;
  String? meaning ;

  WordModel({this.word_id, this.word, this.pronounce, this.meaning});

  WordModel.fromJson(Map<String, dynamic> json)
      :
        this.word_id = json['word_id'],
        this.word = json['word'],
        this.pronounce = json['pronounce'],
        this.meaning = json['meaning'];

   toJson(){
     Map map = Map<String, dynamic>();
     map['word_id'] = this.word_id;
     map['word'] = this.word;
     map['pronounce'] = this.pronounce;
     map['meaning'] = this.meaning;

   }







}
