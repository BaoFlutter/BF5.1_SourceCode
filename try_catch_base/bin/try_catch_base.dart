
import 'dart:io';

import 'package:try_catch_base/try_catch_base.dart' as try_catch_base;

void main(List<String> arguments) {
 var input = "Hello"; 

 try{
   int number = int.parse(input);
 }

 catch(e){
   //print(e.toString());
   print("Đầu vào không phải dạng số");
 }

 finally{
   int a = 5; 
   int b = 6; 
   int c = a + b; 
   print("Tổng 2 số: $c" );
   try{
     int d = int.parse(input);
   }
   catch(e){
     print("Lỗi ở finally");
   }
 }

 print("Kết thúc !");

 //checkAge(-8);
 //checkAge(200);
 checkAge(60);

 
}

// hàm kiểm tra tuổi
checkAge(int age){
  if(age <0 ){
    throw Exception("số tuổi nhập vào là số âm");
  }
  else if(age > 130) {
    throw Exception("Số tuổi nhập vào không khả dụng");
  }
  else {
    print("Năm sinh của người này là: " + ( 2021 - age).toString());
  }

}