import 'package:flutter/material.dart';
Widget customButton ({ @required onPressed, @required buttonName}){
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Center(child: Text(buttonName, style: TextStyle(color: Colors.white),),),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blue
      ),
    ),
    onTap: onPressed,
  );

}

Widget textInputWidget({ @required labelText , @required hintText, @required controller}){
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 10 ),
    child: TextField(
      decoration: InputDecoration(
        labelText:labelText,
        hintText:  hintText,
        border: OutlineInputBorder(),
      ),
      controller: controller,
    ),
  );
}


Widget textWidget({@required labelText, @required contentText}){
  return Container(
    margin: EdgeInsets.only(top: 10, bottom: 10),
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(labelText+ ":", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),

        ),
        Expanded(
          flex: 3,
          child: Text(contentText)

        ),

      ],
    ) ,
  );

}

