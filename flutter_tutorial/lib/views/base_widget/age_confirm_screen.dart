import 'package:flutter/material.dart';
import 'package:flutter_tutorial/resources/strings.dart';
import 'package:flutter_tutorial/resources/widgets/common_widgets.dart';
class AgeConfirmScreen extends StatefulWidget {
  @override
  _AgeConfirmScreenState createState() => _AgeConfirmScreenState();
}

class _AgeConfirmScreenState extends State<AgeConfirmScreen> {
  TextEditingController? userNameController ;
  TextEditingController? birthYearController;

  String username = "Chưa cập nhật";
  String age = "Chưa cập nhật";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController = TextEditingController();
    birthYearController = TextEditingController();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController!.dispose();
    birthYearController!.dispose();
    print("Kết thúc màn hình");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AGE_CONFIRMATION),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              textInputWidget(labelText: USER_NAME, hintText: USER_NAME_HINT, controller: userNameController),
              textInputWidget(labelText: BIRTH_YEAR, hintText: BIRTH_YEAR_HINT, controller: birthYearController),
              customButton(
                  onPressed: (){
                    setState(() {
                      username = userNameController!.text;
                      age =
                          (2021 - int.parse(birthYearController!.text)).toString();
                    });

                  },
                  buttonName: AGE_CONFIRMATION),
              Card(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      textWidget(labelText: USER_NAME, contentText: username),
                      textWidget(labelText: BIRTH_YEAR, contentText: age),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      )

    );
  }


}
