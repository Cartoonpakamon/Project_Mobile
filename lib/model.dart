//กำหนดข้อมูลที่เก็บในtopic model
class topicModel {
  final int? id; //? คือกรอกหรือไม่กรอกก็ได้
  final String title;
  final String conversation;

  topicModel({this.id,required this.title,required this.conversation}); //ไม่ต้องเรียงกันก็ได้ตัวไหนมาก่อนหลังได้หมด

  topicModel.formMap(Map<String, dynamic> item)
  : id = item['id'],
  title =item['title'],
  conversation = item['conversation'];

  Map<String, Object?> toMap(){
    return {'id' : id, 'title' : title, 'conversation' : conversation};
  }
}