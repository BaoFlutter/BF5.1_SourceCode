import 'package:reactive_programing_base/reactive_programing_base.dart' as reactive_programing_base;
import 'package:rxdart/rxdart.dart';
void main(List<String> arguments) {
  //demBehaviorSubject();
  //demoPublishSubject();

  demoReplaySubject();

}

// Lấy toàn bộ dữ liệu thêm vào sau này và lấy dữ liệu được thêm vào gần nhất 
demBehaviorSubject(){

  BehaviorSubject  behaviorSubject = BehaviorSubject<dynamic>();

  behaviorSubject.listen((value) { 
    print("Lấy dữ liệu lần 1: $value");
  });

  behaviorSubject.add(100);
  behaviorSubject.add(101);

  behaviorSubject.listen((value) { 
    print("Lấy dữ liệu lần 2: $value");
  });

  behaviorSubject.add(200);
  behaviorSubject.add(201);

}

// lấy toàn bộ dữ liệu được thêm vào stream sau này 
demoPublishSubject(){

  PublishSubject  publishSubject = PublishSubject<dynamic>();

  publishSubject.listen((value) { 
    print("Lấy dữ liệu lần 1: $value");
  });

  publishSubject.add(100);
  publishSubject.add(101);

  publishSubject.listen((value) { 
    print("Lấy dữ liệu lần 2: $value");
  });

  publishSubject.add(200);
  publishSubject.add(201);

}

demoReplaySubject(){

  ReplaySubject  replaySubject = ReplaySubject<dynamic>();

  replaySubject.listen((value) { 
    print("Lấy dữ liệu lần 1: $value");
  });

  replaySubject.add(100);
  replaySubject.add(101);

  replaySubject.listen((value) { 
    print("Lấy dữ liệu lần 2: $value");
  });

  replaySubject.add(200);
  replaySubject.add(201);

}
