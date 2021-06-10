import 'package:basic_dart/basic_dart.dart' as basic_dart;

void main(List<String> arguments) {
  
  int myAge = 30; 

  int a = 2; 

   const MY_KEY = "flutter" ;

  final int API_KEY = myAge + 20; 

  DateTime nowTime = DateTime.now();
  print(nowTime.toString());

  var b = 10; 
  var name = "Bao Flutter" ;

  print("$a") ;

  dynamic c = 6.5; 
  dynamic d = "Hello";
  dynamic isLogined = true; 

 

  int x = 5; 
  int y = 6;

  print( tinhTong(x, y).toString()) ;

  int soDu = y%x;

  print("So du cua y / x: $soDu" );

  bool kq = y != x; // true
  bool kq1 = y == x; // false
  bool kq2 = y > x;   // true

  bool kq3 = kq1&&kq2; // false ; && <=> * ; true = 1; false = 0; 1 && 1 = 1; 1&& 0 = 0; 0 && 0 = 0; 
  bool kq4 = kq1 || kq2 ; // true ; || <=> + ;  true = 1; false = 0; true || false = 1; 1 || 1 = 1; 0 || 0 = 0 
  
  String string = "Hello";
  //kiemtraChanLe(y);
  //kiemtraChanLe(string);

  /*
  Thuc hanh for ... in 
  */



  List<int> numberList = [ 1, 6, 7,4];
  print ("Tong trong list: " + tinhTongTrongList(numberList).toString());

  //  List 

  List<int> list  = List(); 

  List list2 = [];

  List list3 = [ 3, 4,  5.6, true, "Hello" ];

  print("Do dai cua list 3: " + list3.length.toString());

  list3.add("String");

  print(list3.toString());

  // Map : key : value 

  Map<String, int> map = Map<String, int>(); 
  map = {
   "id" : 2, 
   "age" : 30
  };

  print("Tuoi la: " + map['age'].toString());

  Map<dynamic, dynamic> map2 = Map<dynamic, dynamic>(); 
  map2 = {

    "id" : 5, 
    6 : "Hello",
    "name" : "Bao Flutter"
  };

//  Bai Tap
List list5=[4,3,10,9,15,7,6,5,8];

int tong = tinhTongCacSoChiaHetCho3(list5) ;
print("Tong cac so chia het cho 3: $tong");



}

tinhTongCacSoChiaHetCho3(list)
{
  int sum = 0; 

  for(int number in list)
  {
    if(number%3 == 0) sum = sum + number ; 

  }
  return sum ; 
}

tinhTongTrongList(List list){
 
 int result = 0; 
 for(int i = 0 ; i< list.length ; i ++)
 {
   result = result + list[i];
 }

 /*

 for(var x in list)
 {

  result += x;  // result = result + x; 
 } 
 */

 return result ; 

}

kiemtraChanLe(n)
{
 if(n%2==0) print ("So do la so chan");
 else print ("So do la so le");
}

tinhTong(a, b){

return a + b; 

}

sendMessage()
{
  print("Hello");
  return; 

}

