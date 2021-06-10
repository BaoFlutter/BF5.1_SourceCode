import 'package:dart_oop/dart_oop.dart' as dart_oop;

import 'user.dart';
import 'xe_oto.dart';
import 'xe_tai.dart';

void main(List<String> arguments) {
 
User baoFlutter1 = User(3, "Bao Flutter", 30, "0349582808", "HaNoi VietNam" );
User student1 = User(4, "Student1", 20, "034958994", "HaNoi" );
User student2 = User(4, "Student2", 18, "034958994", "HaNoi" );

List<User> userList = [baoFlutter1, student1, student2];
print("Danh sach nguoi co tuoi khong lon hon 20: ");
for(User user in userList)
{
  if(user.age <= 20) print(user.name);

}

baoFlutter1.renameUser(name: "Baoflutter.com");
print(baoFlutter1.name);


baoFlutter1.name = "Pham Van Bao";
print(baoFlutter1.getPhoneNumber());
baoFlutter1.setPhoneNumber("054992758275");
print(baoFlutter1.getPhoneNumber());

////////====================


XeOto oto1 = XeOto(name: "Lux2.0", brand: "VinFast");
oto1.showInformation();
oto1.chuyenCho();

XeTai xeTai1 = XeTai(brand: "Huyndai", name: "Ben");
xeTai1.chuyenCho();











}
