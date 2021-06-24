import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_getx_flutter/providers/getx_user_information_controller/user_information_controller.dart';
import 'package:provider_getx_flutter/providers/user_information_provider/user_information_model.dart';
import 'package:provider_getx_flutter/resources/strings.dart';
import 'package:provider_getx_flutter/resources/widgets/common_widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_getx_flutter/views/information_display/information_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController? usernameController, phoneNumberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController!.dispose();
    phoneNumberController!.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final changeInfor = Provider.of<UserInformationModel>(context);

    return Scaffold(
      appBar: AppBar(
        title : Text(INFORMATION_INPUT),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(right: 15, left: 15),
          child: Column(
            children: [
              textInputWidget(labelText: USERNAME, hintText: USERNAME_HINT, controller: usernameController),
              textInputWidget(labelText: PHONE_NUMBER, hintText: PHONE_NUMBER_HINT, controller: phoneNumberController),
              customButton(
                  onPressed: (){
                    Get.put(UserInformationController()).updateInformation(
                        userName: usernameController!.text,
                        phoneNumber: phoneNumberController!.text);
                    /*
                    changeInfor.updateInformation(
                        userName: usernameController!.text,
                        phoneNumber: phoneNumberController!.text);
                     */
                    /*
                    context.read<UserInformationModel>().updateInformation(
                        userName: usernameController!.text,
                        phoneNumber: phoneNumberController!.text);

                     */
                    /*
                    var route = MaterialPageRoute(builder: (context) => InformationScreen());
                    Navigator.push(context, route);

                     */

                    Get.snackbar("Thông báo", "Đã cập nhật ProviderGetX");
                    Get.to(InformationScreen());

              },
                  buttonName: CONFIRM)

            ],
          ),
        ),
      ),

    );
  }
}
