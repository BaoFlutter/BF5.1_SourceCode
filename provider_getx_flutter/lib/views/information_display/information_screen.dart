import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_getx_flutter/providers/getx_user_information_controller/user_information_controller.dart';
import 'package:provider_getx_flutter/providers/user_information_provider/user_information_model.dart';
import 'package:provider_getx_flutter/resources/strings.dart';
import 'package:provider_getx_flutter/resources/widgets/common_widgets.dart';
import 'package:provider/provider.dart';
class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final changeInfor = Provider.of<UserInformationModel>(context);
    final UserInformationController userInformationGetX = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(USER_INFORMATION),
      ),
      body: Container(
        child: Column(
          children: [
            /*
            textWidget(
                labelText: USERNAME,
                contentText: context.watch<UserInformationModel>().userName),
            textWidget(labelText: PHONE_NUMBER, contentText: context.watch<UserInformationModel>().phoneNumber),

             */

            textWidget(
                labelText: USERNAME,
                contentText: userInformationGetX.userName),
            textWidget(labelText: PHONE_NUMBER, contentText: userInformationGetX.phoneNumber),


            /*
            textWidget(
                labelText: USERNAME,
                contentText: changeInfor.userName),
            textWidget(labelText: PHONE_NUMBER, contentText: changeInfor.phoneNumber),

             */




          ],
        ),

      ),
      /*
       body: Container(
        child: Consumer<UserInformationModel>(
          builder: (context,userInformation, child){
            return Column(
              children: [
                /*
            textWidget(
                labelText: USERNAME,
                contentText: context.watch<UserInformationModel>().userName),
            textWidget(labelText: PHONE_NUMBER, contentText: context.watch<UserInformationModel>().phoneNumber),
             */
            textWidget(
                labelText: USERNAME,
                contentText: userInformation.userName),
            textWidget(labelText: PHONE_NUMBER, contentText: userInformation.phoneNumber),

              ],
            );
          },

        )
      ),
       */
    );
  }
}
