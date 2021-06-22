import 'package:flutter/material.dart';
import 'package:flutter_sqflite_base/data_sources/databases/mark_database/mark_database.dart';
import 'package:flutter_sqflite_base/data_sources/databases/mark_database/mark_model.dart';
import 'package:flutter_sqflite_base/pages/all_mark/all_mark.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController mathController = TextEditingController();
  TextEditingController litetureController = TextEditingController();
  TextEditingController englishController = TextEditingController();

  final mark_db = MarkDatabase();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    mathController.dispose();
    litetureController.dispose();
    englishController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(40),
            child: Column(
              children: [
                textFieldWidget(
                    controller: usernameController,
                    hintText: "Nhập Họ Và Tên",
                    labelText: "Họ Và Tên"),
                textFieldWidget(
                    controller: mathController,
                    hintText: "Nhập Toán",
                    labelText: "Toán"),
                textFieldWidget(
                    controller: litetureController,
                    hintText: "Nhập Văn",
                    labelText: "Ngữ Văn"),
                textFieldWidget(
                    controller: englishController,
                    hintText: "Nhập Tiếng Anh",
                    labelText: "Tiếng Anh"),
                ElevatedButton(
                    onPressed: () async {
                      MarkModel markModel = MarkModel(
                          user_name: usernameController.text,
                          math_mark: double.parse(mathController.text),
                          liteture_mark: double.parse(litetureController.text),
                          english_mark: double.parse(englishController.text)
                      );

                      mark_db.addMark(markModel).then((value) {
                        var route = MaterialPageRoute(builder: (context) => AllMark());
                        Navigator.push(context, route);
                      });



                    },
                    child: Text("Save Mark"))

              ],
            ),
          ),
        ),
      ),
    );
  }

  textFieldWidget({@required controller, @required hintText, @required labelText})
  {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
            labelText: labelText
        ),
      ),
    );
  }
}
