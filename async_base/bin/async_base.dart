
import 'package:async_base/async_base.dart' as async_base;

void main(List<String> arguments) async {
  //int number = 10 ; 
  //int number = await taoNumberTre();
  //print ("Số là $number");
  // then 
  /*
  taoNumberTre().then((number) {
    print("Số là : $number");
  });
  */
  Stream<int> numberStream = Stream<int>.periodic(
        Duration(seconds: 2),
        makeNumber,
     );
     /*
     numberStream.listen((number) { 
       print("Số là : $number");
     });
     */

    /*

     await for(int number in numberStream){

     print("Số là : $number");

     }
     */

    var stream = countStream(12);
    stream.listen((number) { 
       print("Số là : $number");
     });

    

}

Stream<int> countStream(int max) async*
{
  for(int i = 1 ; i<= max ; i++)
  {
    yield i; 
  }

}
 Future<int> taoNumberTre(){
  return Future.delayed(
    Duration(seconds: 2),
    (){
      return 5;
    }
    );

}



  int makeNumber ( int value) => (value+ 1);

 
