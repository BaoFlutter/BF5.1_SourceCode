import 'dart:io';

import 'package:base_dart/base_dart.dart' as base_dart;

void main(List<String> arguments) {
  int a = 10; 
  String b = "Flutter";
  int c = 6;
  int myAge = 30; 
  myAge = a + c ; 
  const String KEY = "Flutter Developer";
  myAge = 7;
  final int VALUE  =  myAge + 2; 
  print("$VALUE");
  print(" Well");
  print(myAge.toString());

  bool isLogined = false;
  if(isLogined){
    print("Đã đăng nhập");
  }
  else {
    print("Chưa đăng nhập");
  }
  int x = 5; 
  int y  = 6; 

  int tong = tinhTong(x, y);
  print("Tổng 2 số x và y:  $tong "); 

  // Toán tử gán 
  /*
  +=,-=.
  *=,/=,%=
  */

  x+= 2; // x = x + 2; 
  x%= 2; // x = x % 2; 
  
  // Toán tử so sánh : >,<,>=,<=,!=,==,&&,||
  int m = 5; 
  int n  = 6; 
  bool result = m != n ;
  if(m < n) {print ("True"); }

  // && <=> ( * ) : true = 1; false = 0 ; 1 && 0 = 0 ; 1 && 1 = 1;  0 && 0 = 0 ; 
  // || <=> ( + ) : true = 1; false = 0 ; 1 || 0 = 1 ; 1 || 1 = 1 ;  0 || 0 = 0 ; 

  result = ( 7 > 5) && ( 6 < 2) ;

  soSanh();
  xemXetChiaHetCho3(6);

  //print("Giá trị giai thừa của 3 là: " + tinhGiaiThua(3).toString());

  print("Giá trị giai thừa của 3 là: " + tinhGiaiThuaWhile(3).toString());

  List<int> numberList = [2, 4, 5, 6 ];
  List<String> stringList = ["2", "4", "5", "6" ];
  List  list =  List(); 

  print(stringList.length.toString()); 
  print("Phần tử thứ nhất: " + numberList[2].toString());

  inRaSoChan(numberList);







}

void inRaSoChan(List<int> list){
  /*

  for(int i = 0 ; i <= list.length - 1; i++)
  {
   if(list[i]%2 == 0) print(list[i].toString()+ "\n");
  }

  */

  for(int x in list)
  {
    if(x % 2 == 0) print (x.toString());
  }



  

}

int tinhTong(int a, int b)
{
return a + b; 
}

void soSanh()
{
  bool kq ; 
if( 5 > 6 ) {
  kq = true; 
  print(" 5 lớn 6");
}
else if(5 < 6)
{
  print(" 5 nhỏ hơn 6");
}
else {
  print (" 5 = 6");
}
}

void sendMessage()
{
  print("Hello Everyone");
  print(" Tông 2 số 5 và 4 :" + tinhTong(5, 4).toString());
  return ; 

}

int tinhSoDu(int soBiChia, int soChia){
  

  return soBiChia%soChia;


}

void xemXetChiaHetCho3( int a )
{
  switch(a % 3)
  {
    case 0:
    print(" Số này chia hết cho 3");
    break;

    case 1: 
    print(" Số này không chia hết cho 3");
    break;

    default:
    print("Không thể xác định");
    break; 
    
  }
  print("Kết thúc");

}


int tinhGiaiThua(int n ){

   int result = 1; 

   for(int i = 1; i<= n ; i++ )
   {

     int oldResult = result ; 
     result = result * i ; 
     print("Lần $i, Biểu thức result = $oldResult * $i  là:  $result" ) ; 
   }

   return result; 

}

int tinhGiaiThuaWhile(int n ){

   int result = 1; 
   while(n > 0)
   {
     result = result * n; 
     n-- ; 

   }
   return result; 

}

int tinhGiaiThuaDoWhile(int n ){

   int result = 1; 
   int i = 1; 
   do
   {
     result = result * i; 
     // 1 * 1 
     // 1 * 1 * 2
     // 1* 1* 2 * 3

     i ++ ; 

   }while(i <= n) ;

   return result; 

}