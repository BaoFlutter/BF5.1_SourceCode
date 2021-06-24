import 'package:get/get.dart';

class UserInformationController extends GetxController  {

  String userName = "Chưa cập nhật";
  String phoneNumber = "Chưa cập nhật" ;

  updateInformation({userName, phoneNumber}){
    this.userName = userName;
    this.phoneNumber = phoneNumber;
    update();
  }



}