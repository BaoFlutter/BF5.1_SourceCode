import 'package:flutter/material.dart';
import 'package:flutter_tutorial/resources/strings.dart';
class NoStateScreen extends StatelessWidget {
  String string = "hello";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(NO_STATE_SCREEN),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(string),
              ElevatedButton(onPressed: (){
                setState(){
                  string = "hihi";

                }
              }, child: Text("Test"))

            ],
          ),
        ),
      ),
    );
  }
}
