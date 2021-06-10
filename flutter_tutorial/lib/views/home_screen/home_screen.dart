import 'package:flutter/material.dart';
import 'package:flutter_tutorial/resources/strings.dart';
import 'package:flutter_tutorial/resources/widgets/common_widgets.dart';
import 'package:flutter_tutorial/views/base_widget/age_confirm_screen.dart';
import 'package:flutter_tutorial/views/no_state_screen/no_state_screen.dart';
import 'package:flutter_tutorial/views/student_grade/student_grade_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(FLUTTER_TOTAL),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,

            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                customButton(
                  buttonName: AGE_CONFIRMATION,
                    onPressed: (){
                      var route = MaterialPageRoute(builder: (context)=> AgeConfirmScreen());
                      Navigator.push(context, route);

                    }),
                customButton(
                    buttonName: NO_STATE_SCREEN,
                    onPressed: (){
                      var route = MaterialPageRoute(builder: (context)=> NoStateScreen());
                      Navigator.push(context, route);

                    }),
                customButton(
                    buttonName: STUDENT_GRADE,
                    onPressed: (){
                      var route = MaterialPageRoute(builder: (context)=> StudentGradeScreen());
                      Navigator.push(context, route);
                    }),

              ],
            )
        )
    );
  }




}