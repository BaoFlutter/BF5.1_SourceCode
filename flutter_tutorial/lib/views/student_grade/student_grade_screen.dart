import 'package:flutter/material.dart';
import 'package:flutter_tutorial/resources/strings.dart';
import 'package:flutter_tutorial/resources/widgets/common_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StudentGradeScreen extends StatefulWidget {
  @override
  _StudentGradeScreenState createState() => _StudentGradeScreenState();
}

class _StudentGradeScreenState extends State<StudentGradeScreen> {

  TextEditingController? mathMarkController, literatureMarkController, englishMarkController;
  double averageMark = 0.0;
  String grade = "Chưa có thông tin";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String>? average_grade ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mathMarkController = TextEditingController();
    literatureMarkController = TextEditingController();
    englishMarkController = TextEditingController();
    getInformation();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mathMarkController!.dispose();
    literatureMarkController!.dispose();
    englishMarkController!.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(STUDENT_GRADE),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                textInputWidget(
                    labelText: MATH_MARK,
                    hintText: MATH_MARK_INPUT,
                    controller: mathMarkController),
                textInputWidget(
                    labelText: LITERATURE_MARK,
                    hintText: LITERATURE_MARK_INPUT,
                    controller: literatureMarkController),
                textInputWidget(
                    labelText: ENGLISH_MARK,
                    hintText: ENGLISH_MARK_INPUT,
                    controller: englishMarkController),
                customButton(
                    onPressed: (){

                      setState(() {
                        averageMark = getAverageMark(
                            mathMark: double.parse(mathMarkController!.text),
                            literatureMark: double.parse(literatureMarkController!.text),
                            englishMark: double.parse(englishMarkController!.text));
                        grade = getGrade(averageMark)!;

                      });

                      saveInformation(averageMark: averageMark, grade: grade);


                    },
                    buttonName: STUDENT_GRADE),


                resultWidget(averageMark: averageMark, grade: grade),
                viewOldResult(average_grade!)
              ],
            )
        ),
      )
    );
  }

  double getAverageMark({ @required double? mathMark, @required double? literatureMark , @required double? englishMark}){
    return (mathMark! + literatureMark! + englishMark!) / 3;
  }

  String? getGrade(double avarageMark)
  {
    if(avarageMark < 5) return BAD_GRADE;
    else if (avarageMark < 8.5) return NORMAL_GRADE;
    else if(avarageMark >= 8.5)  return EXCELLENT_GRADE;
    else if ((avarageMark < 0 ) ||(avarageMark! >10.0))
      return NOT_NORMAL;
  }

   resultWidget({@required double? averageMark , @required String? grade}){
    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Text(RESULT),
            textWidget(labelText: AVERAGE_MARK,

                contentText: averageMark.toString()),
            textWidget(labelText: GRADE, contentText: grade)

          ],
        ),
      ),
    );

  }

  saveInformation({@required double? averageMark, @required String? grade}) async {
    final prefs = await _prefs;
    await prefs.setString("average_grade", AVERAGE_MARK + averageMark.toString() + "," + GRADE +":" +  grade! );
  }

  Future<String>? getInformation(){
    average_grade = _prefs.then((SharedPreferences? prefs){
      return (prefs!.getString("average_grade")!);
    });

  }

  Widget viewOldResult(Future<String> average_grade)
  {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(PREVIOUS_RESULT),
            Center(
              child: FutureBuilder<String>(
                  future: average_grade,
                  builder: (context, snapshot)
                  {
                    if((snapshot.hasError)||(!snapshot.hasData))
                      //return CircularProgressIndicator();
                      return Text(NOT_AVAILABLE);
                    String? result = snapshot.data;
                    return Text(result!);
                  }),
            ),
          ],
        )
      ),
    );
  }






}
