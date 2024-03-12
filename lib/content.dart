//เป็นข้อมูลชื่อ รูป อายุ ที่จะขึ้นในหน้าswipe_card_page
class Content {
  final String title;
  final String imageURL; // เปลี่ยนฟิลด์ color เป็น imageUrl
  final String age;
  Content(this.title, this.imageURL,this.age);
}

List<Content> contents = [
  Content('Taylor ', 'assets/images/TaylorSwift.jpg','Age : 34'), // ใช้ที่อยู่ของรูปภาพแทนสี
  Content('Tom F.', 'assets/images/tomfel.jpg','Age : 36'), // ใช้ที่อยู่ของรูปภาพแทนสี
  Content('Emma ', 'assets/images/emmawatson.jpg','Age : 33'), // ใช้ที่อยู่ของรูปภาพแทนสี
  Content('Tom H. ', 'assets/images/tomholland.jpg','Age : 27'), // ใช้ที่อยู่ของรูปภาพแทนสี
  Content('Margot', 'assets/images/Margot.jpg','Age : 33'), // ใช้ที่อยู่ของรูปภาพแทนสี
  Content('Robert ', 'assets/images/Robert Pattinson.jpg','Age : 37'), // ใช้ที่อยู่ของรูปภาพแทนสี
  Content('Jennifer', 'assets/images/JenniferLawrence.jpg','Age : 33'), // ใช้ที่อยู่ของรูปภาพแทนสี
  Content('JK', 'assets/images/jungkook.jpg','Age : 26'), // ใช้ที่อยู่ของรูปภาพแทนสี
  Content('Chris', 'assets/images/ChrisHemsworth.jpg','Age : 40'), // ใช้ที่อยู่ของรูปภาพแทนสี
  Content('Inanna', 'assets/images/inanna.jpg','Age : 30'), // ใช้ที่อยู่ของรูปภาพแทนสี
];